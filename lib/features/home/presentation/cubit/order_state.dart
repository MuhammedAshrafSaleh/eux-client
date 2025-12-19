// lib/cubits/orders_state.dart

import 'package:equatable/equatable.dart';
import 'package:eux_client/features/home/data/order_model.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object?> get props => [message];
}

// State for single order fetch
class OrderLoading extends OrdersState {}

class OrderLoaded extends OrdersState {
  final OrderModel order;

  const OrderLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderNotFound extends OrdersState {}
