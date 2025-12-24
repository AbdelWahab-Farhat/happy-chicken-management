import 'package:flutter/material.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';

import '../../bills_settlement/widgets/text_with_value.dart';

class OrderIdWithPaymentMethod extends StatelessWidget {
  final OrderModel orderModel;
  const OrderIdWithPaymentMethod({
    super.key, required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithValue(
          title: "رقم الطلب :",
          value: orderModel?.attributes.orderNumber.toString() ?? "000",
          titleColor: context.colorScheme.onSurface,
        ),
        TextWithValue(
            title: "طريقة الدفع :",
            value: orderModel.attributes.paymentMethod,
            titleColor: context.colorScheme.onSurface),
      ],
    );
  }
}
