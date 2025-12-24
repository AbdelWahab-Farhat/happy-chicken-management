import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_chicken_restaurant/controllers/login_controller/login_cubit.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/utils/validators.dart';

import '../../../utils/styles.dart';
import '../../../widgets/custom_form_field.dart';
import 'image_with_overlay.dart';
import 'login_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBody: false,
        extendBodyBehindAppBar: false,
        body: Stack(

          children: [ImageWithOverLay(), LoginSection()],
        ),
      ),
    );
  }
}

class LoginSection extends StatelessWidget {
  const LoginSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var loginCubit = context.read<LoginCubit>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 0.7.sh,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(36.r),
                topLeft: Radius.circular(36.r))),
        child: Center(
            child: Form(
          key: loginCubit.formKey,
          child: ListView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
              children: [
                SvgPicture.asset("lib/assets/images/happy-chicken-logo.svg"),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "أسم الفرع",
                  style: Styles.styles16(context)
                      .copyWith(color: context.colorScheme.primary),
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormField(
                  hint: "ادخل اسم الفرع",
                  validator: emptyFieldValidator,
                  onSaved: loginCubit.onSavedEmail,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "كلمة المرور",
                  style: Styles.styles16(context)
                      .copyWith(color: context.colorScheme.primary),
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomFormField(
                  hint: "ادخل كلمة المرور",
                  isPassword: true,
                  validator: emptyFieldValidator,
                  onSaved: loginCubit.onSavedPassword,
                ),
                SizedBox(
                  height: 16.h,
                ),
                LoginButton(loginCubit: loginCubit,),
              ]),
        )),
      ),
    );
  }
}
