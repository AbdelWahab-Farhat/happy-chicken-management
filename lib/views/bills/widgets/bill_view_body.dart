
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/controllers/orders_cubit/orders_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/search_controller/search_cubit.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/utils/styles.dart';
import 'package:happy_chicken_restaurant/widgets/main_app_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../bills_settlement/widgets/bill_card.dart';

class BillViewBody extends StatelessWidget {
  const BillViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MainAppBar(title: "الفواتير"),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: SearchTextField(),
              ),
            ),
            BlocBuilder<OrdersCubit, PagingState<int, OrderModel>>(
              builder: (context, state) {
                var cubit = context.read<OrdersCubit>();
                var search = context.read<SearchCubit>().searchController.text;
                return PagedSliverList(
                    state: state,
                    fetchNextPage: () =>
                        cubit.fetchNextOrderPage(state.keys?.last ?? 1, search),
                    builderDelegate: PagedChildBuilderDelegate<OrderModel>(
                      itemBuilder: (context, item, index) {
                        return BillCard(
                          orderModel: item,
                        );
                      },
                      firstPageErrorIndicatorBuilder: (context) => Center(
                        child: Text(
                          state.error.toString() ?? "خطأ في تحميل البيانات",
                          style: Styles.styles20(context),
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => Center(
                        child: Text(
                          "لا توجد فواتير  حالياً",
                          style: Styles.styles20(context),
                        ),
                      ),
                      noMoreItemsIndicatorBuilder: (context) => Center(
                        child: Text(
                          "لا يوجد المزيد من الفواتير",
                          style: Styles.styles20(context),
                        ),
                      ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        var cubit = context.read<SearchCubit>();
        var pagingCubit = context.read<OrdersCubit>();
        return TextField(
          controller: cubit.searchController,
          onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onEditingComplete: () {
            FocusManager.instance.primaryFocus?.unfocus();
            pagingCubit.clear();
            pagingCubit.fetchNextOrderPage(1, cubit.searchController.text);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
            hintText: "بحث",
            hintStyle: Styles.styles16(context).copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.4)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            suffixIcon: IconButton(
              onPressed: () => cubit.clear(),
              icon: Icon(
                Icons.clear_outlined,
                color: context.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ),
        );
      },
    );
  }
}
