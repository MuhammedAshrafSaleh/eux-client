import 'package:eux_client/features/splash_screen/cubit/splash_cubit.dart';
import 'package:eux_client/features/splash_screen/cubit/splash_state.dart';
import 'package:eux_client/resources/app_assets.dart';
import 'package:eux_client/resources/app_color.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashAuthenticatedState) {
          Navigator.pushReplacementNamed(context, Routes.ordersPage);
        } else if (state is SplashUnAutheticatedState) {
          Navigator.pushReplacementNamed(context, Routes.signIn);
        } else if (state is SplashError) {
          Navigator.pushReplacementNamed(context, Routes.signIn);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(child: Image(image: AssetImage(AppAssets.logo))),
      ),
    );
  }
}
