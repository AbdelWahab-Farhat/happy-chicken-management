import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/views/bill_detail/widgets/bill_detail_card.dart';
import 'package:happy_chicken_restaurant/widgets/main_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../controllers/order_detail_cubit/order_detail_cubit.dart';
import '../../../models/order_model.dart';


class BillDetailViewBody extends StatelessWidget {
  const BillDetailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailCubit, OrderDetailState>(
      builder: (context, state) {
        OrderModel? order;
        String title = "جاري التحميل...";
        if (state is OrderDetailSuccess) {
          order = state.orderModel;
          title = "الفاتورة رقم ${order.attributes.orderNumber}";
        } else if (state is OrderDetailFailure) {
          return Scaffold(
            appBar: MainAppBar(title: title, centerTitle: false),
            body: Center(child: Text(state.message)),
          );
        }
        return Scaffold(
          appBar: MainAppBar(title:title, centerTitle: false,),
          body: Skeletonizer(
              enabled: state is OrderDetailLoading,
              child: BillDetailCard(orderModel: order,)
          ),
        );
      },
    );
  }
}
