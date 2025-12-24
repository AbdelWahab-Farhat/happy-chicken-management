import 'package:flutter/material.dart';
import 'package:happy_chicken_restaurant/views/home/widgets/order_static_info.dart';
import '../../../widgets/main_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          title: "الرئيسية",
          hasNotification: true,
        ),
        body: ListView(children: [OrderStaticInfoSection()]));
  }
}
