import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/order_detail_cubit/order_detail_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/print_invoice/print_invoice_cubit.dart';
import 'package:happy_chicken_restaurant/views/bill_detail/widgets/bill_detail_view_body.dart';

import '../../models/order_model.dart';

class BillDetailView extends StatelessWidget {
  final OrderModel? order;

  const BillDetailView({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          OrderDetailCubit()
            ..getOrderDetail(order!.id.toString()),
        ),
        BlocProvider(
          create: (context) => PrintInvoiceCubit(),
        ),
      ],
      child: BillDetailViewBody(),
    );
  }
}
