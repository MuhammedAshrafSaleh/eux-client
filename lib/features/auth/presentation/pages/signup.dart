import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/common/widgets/custom_appbar.dart';
import 'package:eux_client/common/widgets/custom_textfeild.dart';
import 'package:eux_client/resources/font_manager.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:eux_client/resources/app_strings.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                AppStrings.createAccount,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSize.s14),
              CustomTextField(
                controller: _firstNameController,
                hintText: AppStrings.firstName,
              ),
              CustomTextField(
                controller: _lastNameController,
                hintText: AppStrings.lastName,
              ),
              CustomTextField(
                controller: _emailController,
                hintText: AppStrings.emailAddress,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: AppStrings.password,
              ),
              const SizedBox(height: AppSize.s10),
              CustomAppButton(onPressed: () {}, title: AppStrings.continueNext),
              const SizedBox(height: AppSize.s10),
              _createNewAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createNewAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppStrings.alreadyHaveAccount,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextSpan(
            text: AppStrings.signIn,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.popAndPushNamed(context, Routes.signIn);
              },
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeightManager.bold),
          ),
        ],
      ),
    );
  }
}
