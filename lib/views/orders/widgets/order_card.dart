import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/utils/styles.dart';

import '../order_detail_view.dart';
import 'order_delivery_type_with_cost.dart';
import 'order_top_section.dart';

class OrderCard extends StatelessWidget {
  final OrderModel orderModel;
  const OrderCard({
    super.key, required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        side: BorderSide(
          width: 1,
          color: context.colorScheme.onSurface.withOpacity(0.2),
        ),
      ),
      child: InkWell(
        onTap: () => context.push(OrderDetailView(orderID: orderModel.id.toString(),)),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderTopSection(orderModel: orderModel),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeaderText(context, "المنتج"),
                    _buildHeaderText(context, "العدد"),
                    _buildHeaderText(context, "السعر"),
                    _buildHeaderText(context, "الإجمالي"),
                  ],
                ),
              ),
              Divider(),
              Column(
                children: orderModel.relationships.products.map((product) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name, style: Styles.styles16(context)),
                      Text(product.quantity.toString(), style: Styles.styles16(context)),
                      Text("${product.unitPrice} د.ل", style: Styles.styles16(context)),
                      Text("${product.totalPrice} د.ل", style: Styles.styles16(context)),
                    ],
                  ),
                )).toList(),
              ),
              Divider(),
              OrderDeliveryTypeWithCost(orderModel: orderModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(BuildContext context, String text) {
    return Text(
      text,
      style: Styles.styles16(context).copyWith(fontWeight: FontWeight.bold),
    );
  }
}
