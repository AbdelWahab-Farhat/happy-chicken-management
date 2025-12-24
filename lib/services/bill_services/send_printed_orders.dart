


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../utils/apis.dart';

class SendPrintedOrders {
  Future<Either<String,String>> sendPrintedOrders(List<String> orderIds) async {
    try {
      Dio dio = GetIt.I.get<Dio>();
      var response = await dio.post(Apis.sendPrintedOrdersInvoices(),data: orderIds);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right('تم ارسال الفواتير بنجاح');
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (error) {
      return Left(error.response?.data['message'] ?? error.message);
    }
  }
}