import 'package:account/formScreen.dart';
import 'package:account/model/transaction.dart';
import 'package:account/provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return TransactionProvider();
          })
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
            useMaterial3: true,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontFamily: 'Roboto', fontSize: 18),
              bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 16),
            ),
          ),
          home: const MyHomePage(title: 'รายการทั้งหมด'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pink.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const FormScreen();
              }));
            },
          )
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return provider.transactions.isEmpty
              ? const Center(
                  child: Text(
                    'ยังไม่มีข้อมูล',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: provider.transactions.length,
                  itemBuilder: (context, int index) {
                    Transaction data = provider.transactions[index];
                    return Card(
                      color: Colors.pink.shade50,
                      shadowColor: Colors.pink.shade200,
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(data.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87)),
                        subtitle: Text(
                          'วันที่บันทึก: ${data.date.day.toString().padLeft(2, '0')}/'
                          '${data.date.month.toString().padLeft(2, '0')}/'
                          '${data.date.year} เวลา '
                          '${data.date.hour.toString().padLeft(2, '0')}:'
                          '${data.date.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.pink.shade300,
                          foregroundColor: Colors.white,
                          child: FittedBox(
                            child: Text(
                              data.amount.toStringAsFixed(0),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
