import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/common/widgets/custom_appbar.dart';
import 'package:eux_client/common/widgets/custom_textfeild.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:eux_client/resources/app_strings.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p100,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.forgetPasswordHeading,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSize.s14),
              CustomTextField(hintText: AppStrings.emailAddress),
              const SizedBox(height: AppSize.s10),
              CustomAppButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.emailSentRoute,
                  );
                },
                title: AppStrings.continueNext,
              ),
              const SizedBox(height: AppSize.s10),
            ],
          ),
        ),
      ),
    );
  }
}
