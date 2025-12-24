import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/login_controller/login_cubit.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/utils/ui_widgets.dart';
import 'package:happy_chicken_restaurant/views/home/home_view.dart';
import 'package:happy_chicken_restaurant/views/root/widgets/root_view_body.dart';

import '../../../widgets/custom_button.dart';

class LoginButton extends StatelessWidget {
  final LoginCubit loginCubit;

  const LoginButton({
    super.key,
    required this.loginCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showCustomSnackBar(context, state.message);
          context.pushAndRemoveUntil(RootView());
        }
        else if (state is LoginFailure) {
          showCustomSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const CircularProgressIndicator();
        }
        else {
          return CustomButton(
            title: "تسجيل دخول",
            onPressed:loginCubit.login,
            height: 50,
          );
        }
      },
    );
  }
}
