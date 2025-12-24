import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';

import '../../utils/apis.dart';

class GetOrdersForPrint {
  Future<Either<String, List<OrderModel>>> getOrdersForPrint() async {
    try {
      Dio dio = GetIt.I.get<Dio>();
      var response = await dio.get(Apis.getOrdersForPrint());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(List<OrderModel>.from(response.data['data'].map((x) => OrderModel.fromJson(x))));
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (error) {
      return Left(error.response?.data['message'] ?? error.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
