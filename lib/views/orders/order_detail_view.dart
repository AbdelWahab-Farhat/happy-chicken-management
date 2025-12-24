import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/confirmation_order_cubit/confirmation_order_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/google_map_controller/google_map_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/order_detail_cubit/order_detail_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/print_invoice/print_invoice_cubit.dart';
import 'package:happy_chicken_restaurant/views/orders/widgets/order_detail_view_body.dart';

class OrderDetailView extends StatelessWidget {
  final String? orderID;

  const OrderDetailView({super.key, this.orderID});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GoogleMapCubit(),
        ),
        BlocProvider(
          create: (context) => OrderDetailCubit()..getOrderDetail(orderID!),
        ),
        BlocProvider(
          create: (context) => ConfirmationOrderCubit(),
        ),
        BlocProvider(
          create: (context) => PrintInvoiceCubit(),
        ),
      ],
      child: OrderDetailViewBody(),
    );
  }
}