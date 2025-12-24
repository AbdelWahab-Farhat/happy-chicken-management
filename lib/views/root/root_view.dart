import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/root_controller/root_cubit.dart';
import 'package:happy_chicken_restaurant/views/root/widgets/root_view_body.dart';

class RootView extends StatelessWidget {
  final int initialIndex;

  const RootView({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(initialIndex),
      child: const RootViewBody(),
    );
  }
}
