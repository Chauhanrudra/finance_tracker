import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionProvider()..loadTransactions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disable debug banner
        home: TransactionListScreen(),
      ),
    );
  }
}

class TransactionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Transactions')),
      body: ListView.builder(
        itemCount: provider.transactions.length,
        itemBuilder: (context, index) {
          final transaction = provider.transactions[index];
          return ListTile(
            title: Text(transaction.category),
            subtitle: Text('${transaction.amount} ${transaction.type}'),
            trailing: Text(transaction.date.toLocal().toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTransactionDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  // Method to show a dialog for adding a new transaction
  void _showAddTransactionDialog(BuildContext context) {
    final _typeController = TextEditingController();
    final _amountController = TextEditingController();
    final _categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type (Income/Expense)'),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Create a new Transaction object and add it using the provider
                final newTransaction = Transaction(
                  id: '', // The ID should be handled by the backend
                  type: _typeController.text.trim(),
                  amount: double.tryParse(_amountController.text) ?? 0.0,
                  category: _categoryController.text.trim(),
                  date: DateTime.now(), // Set the current date
                );

                // Add the transaction using the provider
                Provider.of<TransactionProvider>(context, listen: false)
                    .addTransaction(newTransaction);

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
