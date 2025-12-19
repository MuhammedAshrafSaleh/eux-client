import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eux_client/common/network/network_info.dart';
import 'package:eux_client/features/auth/data/auth_repository.dart';
import 'package:eux_client/features/auth/data/firestore_service.dart';
import 'package:eux_client/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:eux_client/features/home/data/google_sheet_service.dart';
import 'package:eux_client/features/home/presentation/cubit/order_cubit.dart';
import 'package:eux_client/features/splash_screen/cubit/splash_cubit.dart';
import 'package:eux_client/resources/routes_manager.dart';
import 'package:eux_client/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MyApp extends StatefulWidget {
  // Named Constructor
  MyApp._internal();

  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        // Firestore Service
        RepositoryProvider<FirestoreService>(
          create: (context) => FirestoreService(),
        ),
        RepositoryProvider<NetworkInfo>(
          create: (context) => NetworkInfoImpl(
            connectionChecker: InternetConnectionChecker.createInstance(),
            connectivity: Connectivity(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashCubit(
              authRepository: context.read<AuthRepository>(),
              networkInfo: context.read<NetworkInfo>(),
            )..checkAuthStatus(),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
              networkInfo: context.read<NetworkInfo>(),
            ),
          ),
          BlocProvider<OrdersCubit>(
            create: (context) =>
                OrdersCubit(GoogleSheetService())..fetchAllOrders(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          theme: getAppTheme(),
        ),
      ),
    );
  }
}
