import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/views/bill_detail/bill_detail_view.dart';
import 'text_with_value.dart';

class BillCard extends StatelessWidget {
 final OrderModel orderModel;

  const BillCard({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap:() =>  context.push(BillDetailView(order: orderModel,)),
          overlayColor: WidgetStatePropertyAll<Color>(
              context.colorScheme.primary.withValues(alpha: 0.1)),
          child: Container(
            decoration: BoxDecoration(
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Padding(
              padding: EdgeInsets.all(12.0.w),
              child: Column(
                spacing: 16.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextWithValue(
                        title: "رقم الفاتورة :",
                        value: orderModel.attributes.orderNumber.toString(),
                      ),
                      TextWithValue(
                        title: "التاريخ : ",
                        value: orderModel.attributes.createdAt.format(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextWithValue(
                        title: "قيمة الفاتورة : ",
                        value: "${orderModel.attributes.totalPrice} د.ل",
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}

