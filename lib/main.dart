import 'dart:developer';
import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/utils/depancdy_inj.dart';
import 'package:happy_chicken_restaurant/views/auth/login_view.dart';
import 'package:happy_chicken_restaurant/views/root/root_view.dart';
import 'controllers/auth_controller/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  runApp(DevicePreview(
      enabled: kDebugMode,
      builder: (context) {
        return MyApp();
      }));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return BlocProvider(
          create: (context) => GetIt.I.get<AuthCubit>()..checkUserToken(),
          child: MaterialApp(
            title: 'Happy Chicken Restaurant',
            debugShowCheckedModeBanner: false,
            scrollBehavior: const CupertinoScrollBehavior().copyWith(
              scrollbars: false,
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              },
            ),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xff8e4d2e),
                primary: const Color(0xffEE6C24),
              ),
              useMaterial3: true,
            ),
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child ?? const SizedBox(),
              );
            },
            home: AuthGuard(),
          ),
        );
      },
    );
  }
}


class AuthGuard extends StatelessWidget {
  const AuthGuard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous is !AuthLogoutSuccess || current is!AuthLogoutFailure,
      builder: (context, state) {
        if (state is AuthFailure) {
          return const LoginView();
        } else if (state is AuthSuccess) {
          return const RootView();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
