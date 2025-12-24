import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import '../../../utils/styles.dart';

class DetailCardsItems extends StatelessWidget {
  final OrderModel? orderModel;
  const DetailCardsItems({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    if (orderModel == null) {
      return Container();
    }
    return Column(
      children: orderModel!.relationships.products.asMap().entries.map((entry) {
        int index = entry.key + 1;
        var product = entry.value;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: Styles.styles20(context)), // Use product name
                  SizedBox(height: 4.h),
                  Text("العدد: ${product.quantity} | ${product.unitPrice} د.ل",
                      style: Styles.styles16(context)), // Show count & price
                  SizedBox(height: 4.h),
                  Text("الإجمالي: ${product.totalPrice} د.ل",
                      style: Styles.styles16(context).copyWith(
                        color: context.colorScheme.secondary,
                      )), // Calculate total dynamically
                ],
              ),
              SizedBox(width: 10.w),
              Text(
                index.toString().padLeft(2, '0'),
                style: Styles.styles24(context)
                    .copyWith(color: context.colorScheme.primary),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
