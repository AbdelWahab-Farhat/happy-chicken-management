import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';

import '../../../utils/styles.dart';
import '../../../widgets/custom_circle_avatar.dart';
import 'order_id_with_payment_method.dart';


class OrderTopSection extends StatelessWidget {
  final OrderModel orderModel;
  const OrderTopSection({
    super.key, required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap
      (
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start, spacing: 8.w, children: [
      CustomCircleAvatar(),
      SizedBox(
        width: 0.4.sw, // Responsive width
        child: Text(
          orderModel.relationships.user.attributes.name ?? " ",
          style: Styles.styles20(context),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      OrderIdWithPaymentMethod(orderModel: orderModel,)
    ]);
  }
}
