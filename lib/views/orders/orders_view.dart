import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/orders_cubit/orders_cubit.dart';
import 'package:happy_chicken_restaurant/utils/enums/enum_order_status.dart';
import 'package:happy_chicken_restaurant/views/orders/widgets/orders_view_body.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> status = [
      EnumOrderStatus.pending.name
    ];
    var orderCubit = OrdersCubit(status);
    return BlocProvider(
      create: (context) =>orderCubit,
      child: OrdersViewBody(),
    );
  }
}
