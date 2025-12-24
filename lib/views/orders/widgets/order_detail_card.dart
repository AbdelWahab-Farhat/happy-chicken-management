import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/controllers/google_map_controller/google_map_cubit.dart';
import 'package:happy_chicken_restaurant/utils/ui_widgets.dart';
import 'package:happy_chicken_restaurant/views/orders/widgets/order_detail_card_action_buttons.dart';
import 'package:happy_chicken_restaurant/widgets/custom_button.dart';
import 'package:happy_chicken_restaurant/widgets/detail_summary.dart';

import '../../../models/order_model.dart';
import '../../../widgets/detail_items.dart';
import '../../../widgets/detail_payment_method.dart';

class OrderDetailCard extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderDetailCard({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    double lat = double.parse(orderModel?.attributes.location.lat ?? "0.0");
    double lng = double.parse(orderModel?.attributes.location.lng ?? "0.0");
    return ListView(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.all(16.0.w),
      children: [
        DetailCardsItems(orderModel: orderModel,),
        Divider(),
        DetailCardSummary(orderModel: orderModel,),
        SizedBox(height: 16.h),
        Divider(),
        DetailCardPaymentMethod(orderModel: orderModel),
        Divider(),
        SizedBox(height: 16.h),
        OpenClientLocationButton(lat: lat, lng: lng,),
        SizedBox(height: 16.h),
        OrderDetailCardActionButtons(orderModel: orderModel,)
      ],
    );
  }

}

class OpenClientLocationButton extends StatelessWidget {
  final double lat;
  final double lng;
  const OpenClientLocationButton({
    super.key, required this.lat, required this.lng
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleMapCubit, GoogleMapState>(
      listener: (context, state) {
        if (state is GoogleMapFailure) {
          showCustomSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is GoogleMapLoading) {
          return Center(child: const CircularProgressIndicator());
        }
        return CustomButton(title: "عرض موقع العميل على الخريطة",
          onPressed: () => context.read<GoogleMapCubit>().openClientGoogleMaps(lat, lng),
        );
      },
    );
  }
}
