import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/order_detail_cubit/order_detail_cubit.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/widgets/main_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'order_detail_card.dart';

class OrderDetailViewBody extends StatelessWidget {
  const OrderDetailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailCubit, OrderDetailState>(
      builder: (context, state) {
        OrderModel? order;
        String title = "جاري التحميل...";
        if (state is OrderDetailSuccess) {
          order = state.orderModel;
          title = "الطلب رقم ${order.attributes.orderNumber}";
        } else if (state is OrderDetailFailure) {
          return Scaffold(
            appBar: MainAppBar(title: title, centerTitle: false),
            body: Center(child: Text(state.message)),
          );
        }
        return Scaffold(
          appBar: MainAppBar(title: title, centerTitle: false),
          body: Skeletonizer(
            enabled: state is OrderDetailLoading,
            child: OrderDetailCard(
              orderModel: order,
            ),
          ),
        );
      },
    );
  }
}
