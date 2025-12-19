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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _emailController = TextEditingController();

  final _confirmEmailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    // Validate form
    if (_formKey.currentState!.validate()) {
      // Call register function from AuthCubit
      context.read<AuthCubit>().register(
        name: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
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
          if (state is AuthAuthenticated) {
            // Navigate to home/orders page on success
            Navigator.pushReplacementNamed(context, Routes.signIn);
          } else if (state is AuthRegisterSuccess) {
            CustomSnakebar.showSuccessMessage(
              message: 'Registration successful! Welcome!',
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
                      AppStrings.createAccount,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: AppSize.s14),
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Full Name",

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        if (value.length < 2) {
                          return 'First name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.s10),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.number,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length < 10) {
                          return 'Last name must be at least 11 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.s10),
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
                    const SizedBox(height: AppSize.s10),

                    // Confirm Password field
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText:
                          'Confirm Password', // or AppStrings.confirmPassword
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.s10),
                    CustomAppButton(
                      onPressed: isLoading ? null : _handleRegister,
                      title: AppStrings.continueNext,
                    ),
                    const SizedBox(height: AppSize.s10),
                    _loginButton(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
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
