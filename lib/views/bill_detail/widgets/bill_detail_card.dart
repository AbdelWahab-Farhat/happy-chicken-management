import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/controllers/print_invoice/print_invoice_cubit.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/widgets/custom_button.dart';
import 'package:happy_chicken_restaurant/widgets/detail_items.dart';
import 'package:happy_chicken_restaurant/widgets/detail_payment_method.dart';

import '../../../models/order_model.dart';
import '../../../utils/ui_widgets.dart';
import '../../../widgets/detail_summary.dart';
import '../../root/root_view.dart';


class BillDetailCard extends StatelessWidget {
  final OrderModel? orderModel;

  const BillDetailCard({super.key, this.orderModel});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.all(16.0.sp),
      children: [
        DetailCardsItems(orderModel: orderModel,),
        Divider(),
        DetailCardPaymentMethod(orderModel: orderModel,),
        Divider(),
        DetailCardSummary(orderModel: orderModel,),
        Divider(),
        SizedBox(height: 32.h,),
        BlocConsumer<PrintInvoiceCubit, PrintInvoiceState>(
          listener: (context, state) {
            if (state is PrintInvoiceSuccess) {
              showCustomSnackBar(context, "تمت الطباعة بنجاح");
              context.pushAndRemoveUntil(RootView(initialIndex: 3));
            }
            else if (state is PrintInvoiceFailure) {
              showCustomSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is PrintInvoiceLoading) {
              return const CircularProgressIndicator();
            }
            return CustomButton(title: "طباعة الفاتورة",
              onPressed: () {
              if (orderModel == null) return;
              context.read<PrintInvoiceCubit>().printInvoice(orderModel!);
              },
            );
          },
        )
      ],
    );
  }
}
