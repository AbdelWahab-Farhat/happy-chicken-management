import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_chicken_restaurant/models/user_model.dart';
import 'package:happy_chicken_restaurant/services/auth_services/check_user_token.dart';
import 'package:meta/meta.dart';

import '../../services/auth_services/logout.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
   UserModel? userModel;
  AuthCubit() : super(AuthInitial());

  Future<void> checkUserToken() async {
    CheckUserToken checker = CheckUserToken();
    var result = await checker.checkUserToken();
    result.fold((message) => emit(AuthFailure(message: message)), (user) {
      userModel = user;
      emit(AuthSuccess(message: 'تم تسجيل الدخول بنجاح'));
    });
  }

   Future<void> logout() async {
     var logout = Logout();

     var result = await logout.logout();
     result.fold((message) => emit(AuthLogoutFailure(message: message)), (message) {
       userModel = null;
       emit(AuthLogoutSuccess(message: message));
     });
   }
}
