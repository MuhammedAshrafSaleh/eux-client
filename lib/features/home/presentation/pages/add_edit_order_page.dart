import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/common/widgets/custom_textfeild.dart';
import 'package:eux_client/resources/app_strings.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class AddEidtOrder extends StatelessWidget {
  const AddEidtOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p20,
          horizontal: AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSize.s14),
              Text('Customer Name'),
              CustomTextField(hintText: 'Customer Name'),
              const SizedBox(height: AppSize.s10),
              Text('Recevier\'s phonenumber'),
              CustomTextField(hintText: 'Recevier\'s phonenumber'),
              const SizedBox(height: AppSize.s10),
              Text('Another Recevier\'s phonenumber'),
              CustomTextField(hintText: 'Another Recevier\'s phonenumber'),
              const SizedBox(height: AppSize.s10),
              Text('Arrival governorate'),
              CustomTextField(hintText: 'Arrival governorate'),
              const SizedBox(height: AppSize.s10),
              Text('Arrival city'),
              CustomTextField(hintText: 'Arrival city'),
              const SizedBox(height: AppSize.s10),
              Text(' Arrival area'),
              CustomTextField(hintText: 'Arrival area'),
              const SizedBox(height: AppSize.s10),
              Text('Receiver street'),
              CustomTextField(hintText: 'Receiver street'),
              const SizedBox(height: AppSize.s10),
              Text('Goods weight'),
              CustomTextField(hintText: 'Goods weight'),
              const SizedBox(height: AppSize.s10),
              Text('Total Amount'),
              CustomTextField(hintText: 'Total Amount'),
              const SizedBox(height: AppSize.s10),
              Text('Express Product'),
              CustomTextField(hintText: 'Express Product'),
              const SizedBox(height: AppSize.s10),
              Text('Customer Name'),
              CustomTextField(hintText: AppStrings.emailAddress),
              const SizedBox(height: AppSize.s10),
              CustomAppButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.ordersPage);
                },
                title: 'Add Order',
              ),
              const SizedBox(height: AppSize.s40),
            ],
          ),
        ),
      ),
    );
  }
}
