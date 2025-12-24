import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/controllers/auth_controller/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_options.dart';
import 'fcm_config.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (Platform.isAndroid) {
    await FcmConfig.init();
  }

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://happy-chicken-restaurant.onrender.com/api/v1',
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
      }
    ),);
  // dio.interceptors.add(PrettyDioLogger(
  //   // requestHeader: true,
  //   requestBody: true
  // ));
  getIt.registerLazySingleton<Dio>(() => dio,);
  getIt.registerLazySingleton<AuthCubit> (() => AuthCubit(),);
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences,);
}