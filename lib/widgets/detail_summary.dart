import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';

import '../../../utils/styles.dart';
import '../controllers/auth_controller/auth_cubit.dart';

class DetailCardSummary extends StatelessWidget {
  final OrderModel? orderModel;
  const DetailCardSummary({super.key, this.orderModel});

  @override
  Widget build(BuildContext context) {
    var userModel = GetIt.I.get<AuthCubit>().userModel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryRow("إسم العميل", orderModel?.relationships.user.attributes.name ?? "لا يوجد",context),
        _buildSummaryRow("رقم الهاتف", orderModel?.relationships.user.attributes.phone ?? "0xxxxxxxx",context),
        _buildSummaryRow("عدد المنتجات", orderModel?.relationships.products.length.toString() ?? "0",context),
        _buildSummaryRow("الإجمالي", "${orderModel?.attributes.totalPrice.toString() ?? "0"} د.ل",context),
      ],
    );
  }
}

Widget _buildSummaryRow(String label, String value,BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: Styles.styles16(context).copyWith(fontWeight: FontWeight.bold)),
        Text(value,
            style: Styles.styles16(context).copyWith(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
