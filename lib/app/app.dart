import 'package:eux_client/features/splash_screen/bloc/splash_cubit.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:eux_client/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  // Named Constructor
  MyApp._internel();

  static final MyApp _instance = MyApp._internel();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getAppTheme(),
      ),
    );
  }
}
