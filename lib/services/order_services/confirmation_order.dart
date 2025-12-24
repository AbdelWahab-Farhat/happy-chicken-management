


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/utils/enums/enum_order_status.dart';

import '../../utils/apis.dart';

class ConfirmationOrder {
  final String orderId;

  ConfirmationOrder({required this.orderId});
  Future<Either<String ,String>> confirmationOrder(EnumOrderStatus orderStatus) async {
    var data = {"status": orderStatus.name};
    try {
      Dio dio = GetIt.I.get<Dio>();
      var response = await dio.post(Apis.confirmationOrder(orderId),data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data['message']);
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (error) {
      return Left(error.response?.data['message'] ?? error.message);
    } catch (e) {
      return Left("oops Something went wrong");
    }
  }
}