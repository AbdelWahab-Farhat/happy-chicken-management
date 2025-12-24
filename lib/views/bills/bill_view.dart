import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/orders_cubit/orders_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/search_controller/search_cubit.dart';
import 'package:happy_chicken_restaurant/views/bills/widgets/bill_view_body.dart';

class BillView extends StatelessWidget {
  const BillView({super.key});

  @override
  Widget build(BuildContext context) {
    // ALL
    List<String> states = [];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrdersCubit(states),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: BillViewBody(),
    );
  }
}
