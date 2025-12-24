


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../models/home_model.dart';
import '../../utils/apis.dart';

class GetHomeStaticInfo {
  Future<Either<String, HomeModel>> getHomeStaticInfo() async {
    try {
      Dio dio = GetIt.I.get<Dio>();
      var response = await  dio.get(Apis.getHomeStatics);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(HomeModel.fromJson(response.data['data']));
      }
      else {
        return Left(response.data['message']);
      }
    } on DioException catch (error) {
      return Left(error.response?.data['message'] ?? error.message);
    } catch (e) {
      return Left("Opps Something went wrong");
    }
  }
}