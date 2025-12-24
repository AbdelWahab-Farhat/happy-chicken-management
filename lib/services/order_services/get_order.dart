import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import '../../utils/apis.dart';

class GetOrder {
  final String orderId;
  GetOrder({required this.orderId});

  // TODO THE ORDER BY MODEL CHANGE IT
  Future<Either<String, OrderModel>> getOrder() async {
    try {
      Dio dio = GetIt.I.get<Dio>();
      var response = await dio.get(Apis.getOrder(orderId));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(OrderModel.fromJson(response.data['data']));
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