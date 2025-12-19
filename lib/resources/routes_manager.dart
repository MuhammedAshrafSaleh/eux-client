import 'package:eux_client/features/auth/presentation/pages/email_sent.dart';
import 'package:eux_client/features/auth/presentation/pages/forget_password.dart';
import 'package:eux_client/features/auth/presentation/pages/signin.dart';
import 'package:eux_client/features/auth/presentation/pages/signup.dart';
import 'package:eux_client/features/home/presentation/pages/add_edit_order_page.dart';
import 'package:eux_client/features/home/presentation/pages/orders_page.dart';
import 'package:eux_client/features/home/presentation/pages/track_order_page.dart';
import 'package:eux_client/features/splash_screen/presentation/splash_screen.dart';
import 'package:eux_client/resources/app_strings.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String emailSentRoute = "/emailSentRoute";
  static const String mainRoute = "/main";
  static const String ordersPage = "/ordersPage";
  static const String trackOrder = "/trackOrder";
  static const String addEidtOrder = "/addEidtOrder";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordPage());
      case Routes.emailSentRoute:
        return MaterialPageRoute(builder: (_) => const EmailSentPage());
      case Routes.ordersPage:
        return MaterialPageRoute(builder: (_) => const OrdersPage());
      case Routes.trackOrder:
        return MaterialPageRoute(
          builder: (_) => const OrderTrackingPage(billCode: ''),
        );
      case Routes.addEidtOrder:
        return MaterialPageRoute(builder: (_) => const AddEditOrder());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(AppStrings.noRouteFound)),
        body: Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
