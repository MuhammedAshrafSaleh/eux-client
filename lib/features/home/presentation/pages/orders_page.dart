import 'package:eux_client/features/home/presentation/widgets/order_widget.dart';
import 'package:eux_client/resources/app_color.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Orders'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: AppSize.s16),
          OrderWidget(),
          const SizedBox(height: AppSize.s16),
          OrderWidget(),
          const SizedBox(height: AppSize.s16),
          OrderWidget(),
          const SizedBox(height: AppSize.s16),
          OrderWidget(),
          const SizedBox(height: AppSize.s16),
          OrderWidget(),
          const SizedBox(height: AppSize.s60),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () {
          Navigator.pushNamed(context, Routes.addEidtOrder);
        },
        child: Icon(Icons.add, color: AppColor.white),
      ),
    );
  }
}
