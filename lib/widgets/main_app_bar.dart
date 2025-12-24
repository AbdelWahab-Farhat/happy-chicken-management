import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/auth_controller/auth_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/login_controller/login_cubit.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/utils/ui_widgets.dart';
import 'package:happy_chicken_restaurant/views/notifications/notifications_view.dart';
import 'package:happy_chicken_restaurant/views/root/widgets/root_view_body.dart';

import '../utils/styles.dart';
import '../views/auth/login_view.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool hasNotification;

  const MainAppBar({
    super.key, required this.title, this.centerTitle = true, this.hasNotification = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Styles.styles24(context),
      ),
      actions: [
        if (hasNotification)
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: context.colorScheme.primary,
            ),
            onPressed: () => context.push(NotificationsView()),
          ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLogoutSuccess) {
              showCustomSnackBar(context, state.message);
              context.pop();
              context.push(const LoginView());
            }
            else if (state is AuthLogoutFailure) {
              showCustomSnackBar(context, state.message);
            }

          },
          child: IconButton(
              icon: Icon(
                Icons.logout_outlined,
                color: context.colorScheme.primary,
              ),
              onPressed: () => context.read<AuthCubit>().logout()
          ),
        ),
      ],
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}
