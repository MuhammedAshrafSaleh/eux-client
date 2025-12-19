import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/common/widgets/custom_appbar.dart';
import 'package:eux_client/common/widgets/custom_snakebar.dart';
import 'package:eux_client/common/widgets/custom_textfeild.dart';
import 'package:eux_client/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:eux_client/features/auth/presentation/cubit/auth_state.dart';
import 'package:eux_client/resources/font_manager.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:eux_client/resources/app_strings.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Validate form
    if (_formKey.currentState!.validate()) {
      // Call login function from AuthCubit
      context.read<AuthCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(hideBack: true),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // Handle different states
          if (state is AuthAuthenticated) {
            // Navigate to orders page on success
            Navigator.pushReplacementNamed(context, Routes.ordersPage);
          } else if (state is AuthLoginSuccess) {
            // Show success message
            CustomSnakebar.showSuccessMessage(
              message: 'Login successful! Welcome back!',
              context: context,
            );
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
                      AppStrings.signIn,
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
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.s10),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: AppStrings.password,
                      obscureText: true,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    // ForgetPassword
                    _forgetPasswordOrCreateOneWidget(
                      context: context,
                      text1: AppStrings.forgetPassword,
                      text2: AppStrings.reset,
                      routeName: Routes.forgetPasswordRoute,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSize.s14),
                    CustomAppButton(
                      onPressed: isLoading ? null : _handleLogin,
                      title: AppStrings.continueNext,
                    ),
                    const SizedBox(height: AppSize.s10),
                    _forgetPasswordOrCreateOneWidget(
                      context: context,
                      text1: AppStrings.dontHaveAnAccount,
                      text2: AppStrings.createOne,
                      routeName: Routes.signUp,
                      enabled: !isLoading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _forgetPasswordOrCreateOneWidget({
    required BuildContext context,
    required String text1,
    required String text2,
    required String routeName,
    bool enabled = true,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text1, style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
            text: text2,
            recognizer: enabled
                ? (TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, routeName);
                    })
                : null,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeightManager.bold,
              color: enabled ? null : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
