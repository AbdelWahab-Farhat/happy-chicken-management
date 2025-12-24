import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/utils/styles.dart';
import 'package:happy_chicken_restaurant/widgets/main_app_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../controllers/orders_cubit/orders_cubit.dart';
import '../../../models/order_model.dart';
import 'order_card.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersCubit = context.read<OrdersCubit>();

    return Scaffold(
      appBar: MainAppBar(title: "الطلبات الواردة"),
      body: BlocBuilder<OrdersCubit, PagingState<int, OrderModel>>(
        bloc: ordersCubit,
        builder: (context, state) {
          return PagedListView<int, OrderModel>(
            state: state,
            fetchNextPage: () => ordersCubit.fetchNextOrderPage(state.keys?.last ?? 1,""),
            builderDelegate: PagedChildBuilderDelegate<OrderModel>(
              itemBuilder: (context, item, index) {
                return OrderCard(orderModel: item,);
              },

              firstPageErrorIndicatorBuilder: (context) => Center(
                child: Text(state.error.toString() ?? "خطأ في تحميل البيانات" , style: Styles.styles20(context),),
              ),
              noItemsFoundIndicatorBuilder: (context) => Center(
                child: Text("لا توجد طلبات حالياً",style: Styles.styles20(context),),
              ),
              noMoreItemsIndicatorBuilder: (context) =>  Center(
                child: Text("لا يوجد المزيد من الطلبات",style: Styles.styles20(context),),
              ),
            ),
          );
        },
      ),
    );
  }
}
