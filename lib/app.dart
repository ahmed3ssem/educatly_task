import 'package:educatly_task/feature/home/presentation/cubit/home_cubit.dart';
import 'package:educatly_task/feature/login/presentation/cubit/login_cubit.dart';
import 'package:educatly_task/feature/signup/presentation/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:educatly_task/config/theme/app_theme.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:educatly_task/core/utils/local_strings.dart';
import 'config/routes/app_routes.dart';
import 'injection_container.dart' as di;
import 'widgets/message_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
         BlocProvider(create: (context) => di.sl<LoginCubit>()),
          BlocProvider(create: (context) => di.sl<SignupCubit>()),
          BlocProvider(create: (context) => di.sl<HomeCubit>()),
        ],
        child: MediaQuery(
            data:  MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: GetMaterialApp(
              translations: LocalStrings(),
              locale: const Locale('en', 'US'),
              fallbackLocale: const Locale('en', 'US'),
              theme: appTheme(),
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              scaffoldMessengerKey: MessageWidget.scaffoldMessengerKey,
            )
        )
    );
  }
}