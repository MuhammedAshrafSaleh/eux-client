import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/common/widgets/custom_appbar.dart';
import 'package:eux_client/common/widgets/custom_snakebar.dart';
import 'package:eux_client/common/widgets/custom_textfeild.dart';
import 'package:eux_client/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:eux_client/features/auth/presentation/cubit/auth_state.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:eux_client/resources/app_strings.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text controller
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    // Validate form
    if (_formKey.currentState!.validate()) {
      // Call reset password function from AuthCubit
      context.read<AuthCubit>().resetPassword(
        email: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // Handle different states
          if (state is AuthPasswordResetSuccess) {
            // Show success message
            CustomSnakebar.showSuccessMessage(
              message: state.message,
              context: context,
            );
            // Navigate to email sent page or back to login
            Navigator.pushReplacementNamed(context, Routes.emailSentRoute);
          } else if (state is AuthError) {
            // Show error message
            CustomSnakebar.showErrorMessage(
              message: state.message,
              context: context,
            );
          } else if (state is AuthNoInternet) {
            // Show no internet message
            CustomSnakebar.showErrorMessage(
              message: state.message,
              context: context,
            );
          }
        },
        builder: (context, state) {
          // Check if loading
          final isLoading = state is AuthLoading;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p100,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.forgetPasswordHeading,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppSize.s14),
                    CustomTextField(
                      controller: _emailController,
                      hintText: AppStrings.emailAddress,
                      keyboardType: TextInputType.emailAddress,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Email validation regex
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.s10),
                    CustomAppButton(
                      onPressed: isLoading ? null : _handleResetPassword,
                      title: AppStrings.continueNext,
                    ),
                    const SizedBox(height: AppSize.s10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
