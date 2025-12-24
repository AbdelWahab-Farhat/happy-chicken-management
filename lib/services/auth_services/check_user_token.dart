

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/models/user_model.dart';
import 'package:happy_chicken_restaurant/utils/apis.dart';

class CheckUserToken {

  // other void will be model maybe.
  Future<Either<String,UserModel>> checkUserToken() async {
    Dio dio = GetIt.I.get<Dio>();
    try {
      var response = await  dio.get(Apis.checkUserUrl);
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(UserModel.fromJson(response.data['data']['branch']));
      }
      else {
        return Left(response.data['message'] ?? 'Something went wrong');
      }
    } on DioException catch (error) {
      return Left(error.message ?? error.response?.data['message']);
    }
  }
}