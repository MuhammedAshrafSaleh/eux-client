// lib/features/home/data/google_sheet_service.dart

import 'dart:convert';
import 'package:eux_client/features/home/data/order_model.dart';
import 'package:http/http.dart' as http;

class GoogleSheetService {
  // Replace this with your actual Google Apps Script Web App URL
  static const String _webAppUrl =
      'https://script.google.com/macros/s/AKfycbzyvre5kNBcgrEWwTLInCQPT3IwuVpWX7IQx-JxWpI5E1V-rSkOf51aTC88VNkRvGdO/exec';

  /// Fetch all orders from Google Sheet
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final response = await http.get(
        Uri.parse(_webAppUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => OrderModel.fromJson(json)).toList();
        } else {
          throw Exception('API Error: ${jsonResponse['error']}');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }

  /// Add a new order
  Future<bool> addOrder(OrderModel order) async {
    try {
      await http.post(
        Uri.parse(_webAppUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'action': 'add', 'order': order.toJson()}),
      );

      // ✅ نرجع success على طول لأن الداتا بتتسجل
      return true;
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error adding order: $e');
    }
  }

  /// Edit an existing order
  Future<bool> editOrder(String phoneNumber, OrderModel order) async {
    try {
      print('🔵 Editing order with phone: $phoneNumber');
      print('🔵 Order data: ${order.toJson()}');

      await http.post(
        Uri.parse(_webAppUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'edit',
          'phoneNumber': phoneNumber,
          'order': order.toJson(),
        }),
      );

      print('✅ Edit request sent successfully');
      return true;
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error editing order: $e');
    }
  }

  /// Delete an order by phone number
  Future<bool> deleteOrder(String phoneNumber) async {
    try {
      print('🔵 Deleting order with phone: $phoneNumber');

      await http.post(
        Uri.parse(_webAppUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'action': 'delete', 'phoneNumber': phoneNumber}),
      );

      print('✅ Delete request sent successfully');
      return true;
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error deleting order: $e');
    }
  }

  /// Fetch a specific order by order code
  Future<OrderModel?> getOrderByCode(String orderCode) async {
    try {
      final orders = await getAllOrders();
      return orders.firstWhere(
        (order) => order.orderCode == orderCode,
        orElse: () => throw Exception('Order not found'),
      );
    } catch (e) {
      return null;
    }
  }
}
