import 'package:eux_client/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:eux_client/features/auth/presentation/cubit/auth_state.dart';
import 'package:eux_client/features/home/presentation/cubit/order_cubit.dart';
import 'package:eux_client/features/home/presentation/cubit/order_state.dart';
import 'package:eux_client/features/home/presentation/widgets/order_widget.dart';
import 'package:eux_client/resources/app_color.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushReplacementNamed(context, Routes.signIn);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('My Orders'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: AppColor.white),
              tooltip: 'Logout',
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrdersError) {
              return _buildOrderError(context, state.message);
            } else if (state is OrdersLoaded) {
              final orders = state.orders;

              if (orders.isEmpty) {
                return _buildEmptyOrder();
              }

              return RefreshIndicator(
                onRefresh: () => context.read<OrdersCubit>().refreshOrders(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'عدد الأوردرات : ${orders.length}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppSize.s10),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return OrderWidget(order: order);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('Pull down to load orders'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () {
            Navigator.pushNamed(context, Routes.addEidtOrder);
          },
          child: Icon(Icons.add, color: AppColor.white),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthCubit>().signOut();
            },
            child: Text('Logout', style: TextStyle(color: AppColor.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderError(context, message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColor.error),
          const SizedBox(height: 16),
          Text(
            'Error loading orders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.error,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<OrdersCubit>().fetchAllOrders();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyOrder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'No orders yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start by adding your first order',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
