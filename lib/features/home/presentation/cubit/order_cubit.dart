// lib/cubits/orders_cubit.dart

import 'package:eux_client/features/home/data/google_sheet_service.dart';
import 'package:eux_client/features/home/data/order_model.dart';
import 'package:eux_client/features/home/data/tracking_service.dart';
import 'package:eux_client/features/home/presentation/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GoogleSheetService _googleSheetService;
  final TrackingService _trackingService = TrackingService();
  OrdersCubit(this._googleSheetService) : super(OrdersInitial());

  /// Fetch all orders from Google Sheet
  Future<void> fetchAllOrders() async {
    emit(OrdersLoading());

    try {
      final orders = await _googleSheetService.getAllOrders();
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  /// Add a new order
  Future<void> addOrder(OrderModel order) async {
    try {
      final success = await _googleSheetService.addOrder(order);

      if (success) {
        // Refresh the orders list
        await fetchAllOrders();
      } else {
        emit(OrdersError('Failed to add order'));
      }
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  /// Delete an order
  Future<void> deleteOrder(String phoneNumber) async {
    emit(OrdersLoading());
    try {
      final success = await _googleSheetService.deleteOrder(phoneNumber);

      if (success) {
        // Refresh the orders list
        await fetchAllOrders();
      } else {
        emit(OrdersError('Failed to delete order'));
      }
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  /// Edit an existing order
  Future<void> editOrder(String phoneNumber, OrderModel order) async {
    emit(OrdersLoading());
    try {
      final success = await _googleSheetService.editOrder(phoneNumber, order);

      if (success) {
        // Refresh the orders list
        await fetchAllOrders();
      } else {
        emit(OrdersError('Failed to edit order'));
      }
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  /// Refresh orders (useful for pull-to-refresh)
  Future<void> refreshOrders() async {
    await fetchAllOrders();
  }

  Future<TrackingResponse> trackOrder(String billCode) async {
    try {
      final result = await _trackingService.trackOrder(billCode);
      return result;
    } catch (e) {
      throw Exception('Failed to track order: $e');
    }
  }
}
