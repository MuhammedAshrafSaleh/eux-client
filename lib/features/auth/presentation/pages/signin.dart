import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/common/widgets/custom_appbar.dart';
import 'package:eux_client/common/widgets/custom_textfeild.dart';
import 'package:eux_client/resources/font_manager.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:eux_client/resources/app_strings.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(hideBack: true),
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
                AppStrings.signIn,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSize.s14),
              CustomTextField(hintText: AppStrings.emailAddress),
              const SizedBox(height: AppSize.s10),
              CustomTextField(hintText: AppStrings.password),
              // ForgetPassword
              _forgetPasswordOrCreateOneWidget(
                context: context,
                text1: AppStrings.forgetPassword,
                text2: AppStrings.reset,
                routeName: Routes.forgetPasswordRoute,
              ),
              const SizedBox(height: AppSize.s14),
              CustomAppButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.ordersPage);
                },
                title: AppStrings.continueNext,
              ),
              const SizedBox(height: AppSize.s10),
              _forgetPasswordOrCreateOneWidget(
                context: context,
                text1: AppStrings.dontHaveAnAccount,
                text2: AppStrings.createOne,
                routeName: Routes.signUp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forgetPasswordOrCreateOneWidget({
    required BuildContext context,
    required String text1,
    required String text2,
    required String routeName,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text1, style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
            text: text2,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, routeName);
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
