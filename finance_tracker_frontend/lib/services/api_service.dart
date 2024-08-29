import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaction.dart';

class ApiService {
  // Replace with the correct URL for your backend. For Android emulator use '10.0.2.2'
  final String baseUrl = 'http://10.0.2.2:5000/transactions';

  // Fetch transactions from the backend
  Future<List<Transaction>> fetchTransactions() async {
    try {
      // Sending a GET request to fetch all transactions
      final response = await http.get(Uri.parse(baseUrl));

      // Checking if the response status is OK (200)
      if (response.statusCode == 200) {
        // Parsing the JSON response into a List of Transaction objects
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Transaction.fromJson(json)).toList();
      } else {
        // If the server returns an error, throw an exception
        throw Exception('Failed to load transactions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Print and throw exception if an error occurs
      print('Error fetching transactions: $e');
      throw Exception('Failed to load transactions');
    }
  }

  // Add a new transaction to the backend
  Future<void> addTransaction(Transaction transaction) async {
    try {
      // Sending a POST request to add a new transaction
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'type': transaction.type,
          'amount': transaction.amount,
          'category': transaction.category,
          'date': transaction.date.toIso8601String(),
        }),
      );

      // Checking if the response status is OK (200)
      if (response.statusCode != 200) {
        throw Exception('Failed to add transaction. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Print and throw exception if an error occurs
      print('Error adding transaction: $e');
      throw Exception('Failed to add transaction');
    }
  }
}
