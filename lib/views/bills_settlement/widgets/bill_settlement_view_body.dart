import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/controllers/bills_settlement_controller/bills_settlement_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/orders_cubit/orders_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/print_invoice/print_invoice_cubit.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/utils/ui_widgets.dart';
import 'package:happy_chicken_restaurant/views/bills_settlement/widgets/bill_card.dart';
import 'package:happy_chicken_restaurant/views/bills_settlement/widgets/text_with_value.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../utils/styles.dart';
import '../../../widgets/custom_button.dart';

class BillSettlementViewBody extends StatelessWidget {
  const BillSettlementViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OrdersCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تسوية الفواتير",
          style: Styles.styles20(context),
        ),
      ),
      body: BlocBuilder<OrdersCubit, PagingState<int, OrderModel>>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // TODO ADD THEM WHEN HE SEND THEM WITH API
                    // TextWithValue(title: "عدد الفواتير : ", value: "100"),
                    // TextWithValue(title: "الفواتير الملغاة : ", value: "44"),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(),
              ),
              PagedSliverList(
                  state: state,
                  fetchNextPage: () =>
                      cubit.fetchNextOrderPage(state.keys?.last ?? 1, ""),
                  builderDelegate: PagedChildBuilderDelegate<OrderModel>(
                    itemBuilder: (context, item, index) {
                      return BillCard(
                        orderModel: item,
                      );
                    },
                    firstPageErrorIndicatorBuilder: (context) => Center(
                      child: Text(
                        state.error.toString(),
                        style: Styles.styles20(context),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) => Center(
                      child: Text(
                        "لا توجد فواتير للتسوية حالياً",
                        style: Styles.styles20(context),
                      ),
                    ),
                    noMoreItemsIndicatorBuilder: (context) => Center(
                      child: Text(
                        "لا يوجد المزيد من الفواتير",
                        style: Styles.styles20(context),
                      ),
                    ),
                  )),
            ],
          );
        },
      ),
      bottomNavigationBar: cubit.state.error == null
          ? SafeArea(
              minimum: EdgeInsets.all(16.r),
              child: BlocProvider(
                create: (context) => PrintInvoiceCubit(),
                child: BlocListener<PrintInvoiceCubit, PrintInvoiceState>(
                  listener: (context, state) {
                    if (state is PrintInvoiceSuccess) {
                      showCustomSnackBar(context, "تم الطباعة بنجاح");
                      if (state is BillsSettlementCubit) {
                        context.read<BillsSettlementCubit>().sendAllOrderPrintedIdsToBackend(state.ordersPrintedIds);
                      }
                    } else if (state is PrintInvoiceFailure) {
                      showCustomSnackBar(context, state.message);
                    }
                  },
                  child:
                      BlocBuilder<BillsSettlementCubit, BillsSettlementState>(
                    builder: (context, state) {
                      return CustomButton(
                        title: state is BillsSettlementLoading
                            ? "جاري التحميل..."
                            : "تسوية",
                        onPressed: () async {
                          BillsSettlementCubit billSetCubit =
                              context.read<BillsSettlementCubit>();
                          await billSetCubit.getAllOrdersToPrint();
                          if (state is BillsSettlementSuccess) {
                            showCustomDialog(
                                context: context,
                                title: "تسوية الفواتير",
                                description:
                                    "بضغطك على موافق سيتم تسوية جميع الفواتير وحذفها من فواتير اليوم",
                                onConfirm: () async {
                                  await context
                                      .read<PrintInvoiceCubit>()
                                      .printAllInvoice(state.orders);
                                  context.pop();
                                },
                                image: "");
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
