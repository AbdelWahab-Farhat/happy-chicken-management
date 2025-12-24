import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/login_controller/login_cubit.dart';
import 'package:happy_chicken_restaurant/views/auth/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: LoginViewBody(),
    );
  }
}
