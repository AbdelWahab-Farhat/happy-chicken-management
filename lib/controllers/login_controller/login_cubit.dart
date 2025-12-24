import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/controllers/auth_controller/auth_cubit.dart';
import 'package:happy_chicken_restaurant/services/auth_services/login.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginCubit() : super(LoginInitial());

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    var login = Login(email: email!, password: password!);

    var result = await login.login();
    result.fold((message) => emit(LoginFailure(message)),
        (user) {
          GetIt.I.get<AuthCubit>().userModel = user;
          emit(
            LoginSuccess("تم تسجيل الدخول بنجاح"));
        });
  }

  void onSavedEmail(String? value) {
    email = value!;
  }

  void onSavedPassword(String? value) {
    password = value!;
  }




  @override
  Future<void> close() {
    FocusManager.instance.primaryFocus?.unfocus();
    return super.close();
  }
}
