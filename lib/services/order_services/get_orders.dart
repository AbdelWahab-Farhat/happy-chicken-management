
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../models/order_model.dart';
import '../../utils/apis.dart';

class GetOrders {
  Future<Either<String, List<OrderModel>>> getOrders(int pageKey , List<String> states ,{String? searchQuery}) async {
    try {
      Dio dio = GetIt.I.get<Dio>();
      var response = await dio.get(Apis.getOrdersByState(pageKey,states,searchQuery: searchQuery));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = response.data['data'];
        return Right(data.map((e) => OrderModel.fromJson(e),).toList());
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (error) {
      log(error.toString());
      return Left(error.response?.data['message'] ?? error.message);
    }
  }
}
