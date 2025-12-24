import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/models/home_model.dart';
import 'package:happy_chicken_restaurant/utils/styles.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'order_static_info_box.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderStaticInfoSection extends StatelessWidget {
  const OrderStaticInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 24.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 1.sw,
            child: Image.asset(
              'lib/assets/images/home_image.png',
              fit: BoxFit.contain,
            ),
          ),
          Text("إحصائيات", style: Styles.styles24(context)),
          Divider(indent: 100, endIndent: 100, thickness: 2),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              bool isLoading = state is HomeLoading;
              HomeModel? homeModel;

              if (state is HomeSuccess) {
                homeModel = state.homeModel;
              }
              return Skeletonizer(
                enabled: isLoading,
                child: GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 24.w,
                    mainAxisSpacing: 24.h,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    OrderStaticInfoBox(
                      title: "عدد الطلبيات المكتملة",
                      number: homeModel?.successOrders.toStringAsFixed(0) ?? "0",
                    ),
                    OrderStaticInfoBox(
                      title: "عدد الطلبيات المنتظرة",
                      number: homeModel?.pendingOrders.toStringAsFixed(0) ?? "0",
                    ),
                    OrderStaticInfoBox(
                      title: "عدد الطلبيات الملغاه",
                      number: homeModel?.cancelledOrders.toStringAsFixed(0) ?? "0",
                    ),
                    OrderStaticInfoBox(
                      title: "اجمالي الفواتير",
                      number: homeModel?.orders.toStringAsFixed(0) ?? "0",
                    ),
                  ],
                )
              );
            },
          ),
        ],
      ),
    );
  }
}
