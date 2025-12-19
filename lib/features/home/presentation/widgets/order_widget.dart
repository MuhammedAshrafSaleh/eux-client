import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/features/home/data/order_model.dart';
import 'package:eux_client/features/home/presentation/cubit/order_cubit.dart';
import 'package:eux_client/features/home/presentation/pages/add_edit_order_page.dart';
import 'package:eux_client/features/home/presentation/pages/track_order_page.dart';
import 'package:eux_client/resources/app_color.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  const OrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppMargin.m16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          _orderHeader(order),
          const SizedBox(height: 12),

          // Customer Name
          _cardBodyText(
            headText: 'Customer Name: ',
            bodyText: order.receiver ?? "",
          ),
          const SizedBox(height: AppSize.s8),

          // Recevier's phonenumber
          _cardBodyText(
            headText: 'Recevier\'s phonenumber: ',
            bodyText: order.receiverPhoneNumber ?? "",
          ),
          const SizedBox(height: AppSize.s8),

          // Total Amount
          _cardBodyText(
            headText: 'Total Amount: ',
            bodyText: order.codAmount ?? "0.0\$",
          ),
          const SizedBox(height: AppSize.s8),

          // Express Product
          _cardBodyText(headText: 'Express Product: ', bodyText: 'Standard'),
          const SizedBox(height: AppSize.s8),

          // // COD currency
          // _cardBodyText(headText: 'COD currency: ', bodyText: 'Egypt'),
          // const SizedBox(height: AppSize.s8),

          // Goods weight
          _cardBodyText(
            headText: 'Goods weight: ',
            bodyText: order.goodsWeight ?? '0KG',
          ),
          const SizedBox(height: AppSize.s8),

          // Arrival governorate
          _cardBodyText(
            headText: 'Arrival governorate: ',
            bodyText: order.arrivalGovernorate ?? "",
          ),
          const SizedBox(height: AppSize.s8),

          // Arrival city
          _cardBodyText(
            headText: 'Arrival city: ',
            bodyText: order.arrivalCity ?? "",
          ),
          const SizedBox(height: AppSize.s8),

          // Arrival area
          _cardBodyText(
            headText: 'Arrival area: ',
            bodyText: order.arrivalArea ?? "",
          ),
          const SizedBox(height: AppSize.s8),

          // Receiver street
          _cardBodyText(
            headText: 'Receiver street: ',
            bodyText: order.receiverStreet ?? "",
          ),
          const SizedBox(height: 16),

          // Action Buttons
          _actionButtons(context),
        ],
      ),
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Row(
      children: [
        // Edit Order
        Expanded(
          child: CustomAppButton(
            onPressed: () async {
              // افتح صفحة التعديل
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditOrder(existingOrder: order),
                ),
              );

              // لو التعديل نجح، اعمل refresh
              if (result == true && context.mounted) {
                context.read<OrdersCubit>().refreshOrders();
              }
            },
            title: 'Edit',
            borderRadiusSize: AppSize.s8,
            bgColor: AppColor.primary,
          ),
        ),
        const SizedBox(width: 12),

        // Delete Order
        Expanded(
          child: CustomAppButton(
            onPressed: () async {
              // تأكد إن عندك رقم التليفون
              if (order.receiverPhoneNumber == null ||
                  order.receiverPhoneNumber!.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('لا يوجد رقم تليفون لهذا الطلب'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // اعرض رسالة تأكيد
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('حذف الطلب'),
                  content: Text(
                    'هل تريد حذف الطلب الخاص بـ ${order.receiver}؟\n'
                    'رقم التليفون: ${order.receiverPhoneNumber}',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('حذف'),
                    ),
                  ],
                ),
              );

              // لو المستخدم ضغط إلغاء
              if (confirm != true) return;

              // احذف الطلب باستخدام Cubit
              try {
                await context.read<OrdersCubit>().deleteOrder(
                  order.receiverPhoneNumber!,
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم حذف الطلب بنجاح'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('خطأ: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            title: 'Delete',
            borderRadiusSize: AppSize.s8,
            bgColor: AppColor.error,
          ),
        ),
        const SizedBox(width: 12),

        // Track Order
        order.orderCode!.isNotEmpty
            ? Expanded(
                child: CustomAppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderTrackingPage(billCode: order.orderCode!),
                      ),
                    );
                  },
                  title: 'Track Order',
                  borderRadiusSize: AppSize.s8,
                  bgColor: Colors.white,
                  textColor: AppColor.black,
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _orderHeader(order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          order.orderCode!.isEmpty
              ? "الأورد فى حالة المراجعة"
              : "الأردر رقم  #${order.orderCode}",

          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          '24 June',
          style: TextStyle(fontSize: 12, color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _cardBodyText({required String headText, required String bodyText}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
        children: [
          TextSpan(text: headText),
          TextSpan(
            text: bodyText,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
