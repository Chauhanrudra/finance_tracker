import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];
  final ApiService _apiService = ApiService();

  List<Transaction> get transactions => _transactions;

  Future<void> loadTransactions() async {
    try {
      _transactions = await _apiService.fetchTransactions();
      notifyListeners(); // Notify the UI about the change
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      await _apiService.addTransaction(transaction);
      _transactions.add(transaction); // Add to local list
      loadTransactions(); // Refresh the transaction list from backend
      notifyListeners(); // Update UI
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }
}
