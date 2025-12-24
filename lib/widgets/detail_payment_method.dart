import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';

import '../../../utils/styles.dart';

class DetailCardPaymentMethod extends StatelessWidget {
  final OrderModel? orderModel;
  const DetailCardPaymentMethod({super.key, this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("طريقة الدفع:",
            style: Styles.styles20(context)
                .copyWith(color: context.colorScheme.primary)),
        SizedBox(width: 8.w),
        Text(orderModel?.attributes.paymentMethod ?? "لا يوجد", style: Styles.styles20(context)),
      ],
    );
  }
}
