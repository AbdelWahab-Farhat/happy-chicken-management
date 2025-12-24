import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../models/notification_model.dart';
import '../../utils/apis.dart';

class GetNotifications {
  Future<Either<String, List<NotificationModel>>> getNotifications(
      int pageKey) async {
    try {
      Dio dio = GetIt.I.get<Dio>();
      var response = await dio.get(Apis.getNotifications(pageKey));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(List<NotificationModel>.from(
            response.data['data'].map((x) => NotificationModel.fromJson(x))));
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (error) {
      return Left(error.response?.data['message'] ?? error.message);
    }
  }
}
