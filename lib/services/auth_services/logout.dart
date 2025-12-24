import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/utils/apis.dart';
import 'package:happy_chicken_restaurant/utils/fcm_config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Logout {

  const Logout();
  Future<Either<String, String>> logout() async {
    try {
      SharedPreferences sp =  GetIt.I.get<SharedPreferences>();
      Dio dio = GetIt.I.get<Dio>();
      String? token = await FcmConfig.getToken();
      var data = {"fcmToken": token};
      // it empty token
      var response = await  dio.post(Apis.logoutUrl,data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        sp.clear();
        return Right('تم تسجيل الخروج بنجاح');
      }
      else {
        return Left(response.data['message']);
      }
    } on DioException catch (error) {
      return Left(error.response?.data['message'] ?? error.message);
    }
  }


}
