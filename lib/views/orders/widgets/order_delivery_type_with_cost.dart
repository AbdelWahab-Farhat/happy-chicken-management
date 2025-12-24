import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';

import '../../bills_settlement/widgets/text_with_value.dart';

class OrderDeliveryTypeWithCost extends StatelessWidget {
  final OrderModel orderModel;
  const OrderDeliveryTypeWithCost({
    super.key, required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const orderCostTitle = "تكلفة الطلب : ";
        var orderCostValue = "${orderModel.attributes.totalPrice} د.ل";
        const orderDeliveryTypeTitle = "طريقة الإستلام : ";
        var orderDeliveryTypeValue = orderModel.attributes.orderType;
        if (constraints.maxWidth < 330) {
          return Wrap(
            spacing: 16.w,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextWithValue(
                title: orderCostTitle,
                value: orderCostValue,
                valueColor: Colors.green,
                titleColor: context.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              TextWithValue(
                title: orderDeliveryTypeTitle,
                value: orderDeliveryTypeValue,
                titleColor: context.colorScheme.onSurface,
                valueColor: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ],
          );
        }
        else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWithValue(
                title: orderCostTitle,
                value: orderCostValue,
                valueColor: Colors.green,
                titleColor: context.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              TextWithValue(
                title: orderDeliveryTypeTitle,
                value: orderDeliveryTypeValue,
                titleColor: context.colorScheme.onSurface,
                valueColor: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ],
          );
        }
      },
    );
  }
}
