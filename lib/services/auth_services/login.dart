import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/models/user_model.dart';
import 'package:happy_chicken_restaurant/utils/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/fcm_config.dart';

class Login {
  final String email;
  final String password;

  Login({required this.email, required this.password});
  Future<Either<String, UserModel>> login() async {
    try {
      String? token = "efsefse";
      SharedPreferences sp =  GetIt.I.get<SharedPreferences>();
      if (Platform.isAndroid) {
         token = await FcmConfig.getToken();
      }
      Dio dio = GetIt.I.get<Dio>();
      var data = {"email": email, "password": password,"fcmToken": token};
      var response = await  dio.post(Apis.loginUrl, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        sp.setString('token', response.data['data']['token']);
        dio.options.headers['Authorization'] = 'Bearer ${sp.getString('token')}';

        return Right(UserModel.fromJson(response.data['data']['branch']));
      }
      else {
        return Left(response.data['message']);
      }
    } on DioException catch (error) {
      return Left(error.response?.data['message'] ?? error.message);
    }
  }


}
