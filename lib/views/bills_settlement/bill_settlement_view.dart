import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/bills_settlement_controller/bills_settlement_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/orders_cubit/orders_cubit.dart';
import 'package:happy_chicken_restaurant/views/bills_settlement/widgets/bill_settlement_view_body.dart';

import '../../utils/enums/enum_order_status.dart';


class BillSettlementView extends StatelessWidget {
  const BillSettlementView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> states = [
      EnumOrderStatus.confirmed.name,
      EnumOrderStatus.cancelled.name,
      EnumOrderStatus.pending.name
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrdersCubit(states),
        ),
        BlocProvider(
          create: (context) => BillsSettlementCubit(),
        ),
      ],
      child: BillSettlementViewBody(),
    );
  }
}
