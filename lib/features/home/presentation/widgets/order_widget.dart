import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/resources/app_color.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _orderHeader(),
          const SizedBox(height: 12),

          // Customer Name
          _cardBodyText(
            headText: 'Customer Name: ',
            bodyText: 'Muahmmed Ashraf Saleh Yousef',
          ),
          const SizedBox(height: AppSize.s8),

          // Recevier's phonenumber
          _cardBodyText(
            headText: 'Recevier\'s phonenumber: ',
            bodyText: '01153230472',
          ),
          const SizedBox(height: AppSize.s8),

          // Total Amount
          _cardBodyText(headText: 'Total Amount: ', bodyText: '\$277.0'),
          const SizedBox(height: AppSize.s8),

          // Express Product
          _cardBodyText(headText: 'Express Product: ', bodyText: 'Standard'),
          const SizedBox(height: AppSize.s8),

          // // COD currency
          // _cardBodyText(headText: 'COD currency: ', bodyText: 'Egypt'),
          // const SizedBox(height: AppSize.s8),

          // Goods weight
          _cardBodyText(headText: 'Goods weight: ', bodyText: '12KG'),
          const SizedBox(height: AppSize.s8),

          // Arrival governorate
          _cardBodyText(
            headText: 'Arrival governorate: ',
            bodyText: 'New Cairo',
          ),
          const SizedBox(height: AppSize.s8),

          // Arrival city
          _cardBodyText(headText: 'Arrival city: ', bodyText: 'New Cairo'),
          const SizedBox(height: AppSize.s8),

          // Arrival area
          _cardBodyText(
            headText: 'Arrival area: ',
            bodyText: 'Fifth Settlement',
          ),
          const SizedBox(height: AppSize.s8),

          // Receiver street
          _cardBodyText(
            headText: 'Receiver street: ',
            bodyText:
                'Apartment 12, Building 45, Street 90, Fifth Settlement, New Cairo, Cairo, Egypt',
          ),
          const SizedBox(height: 16),

          // Action Buttons
          _actionButtons(context),
        ],
      ),
    );
  }

  Widget _actionButtons(context) {
    return Row(
      children: [
        // Eidt Order
        Expanded(
          child: CustomAppButton(
            onPressed: () {},
            title: 'Edit',
            borderRadiusSize: AppSize.s8,
            bgColor: AppColor.primary,
          ),
        ),
        const SizedBox(width: 12),
        // Delete Order
        Expanded(
          child: CustomAppButton(
            onPressed: () {},
            title: 'Delete',
            borderRadiusSize: AppSize.s8,
            bgColor: AppColor.error,
          ),
        ),
        const SizedBox(width: 12),
        // Delete Order
        Expanded(
          child: CustomAppButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.trackOrder);
            },
            title: 'Track Order',
            borderRadiusSize: AppSize.s8,
            bgColor: Colors.white,
            textColor: AppColor.black,
          ),
        ),
      ],
    );
  }

  Widget _orderHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Order # 1234',
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
