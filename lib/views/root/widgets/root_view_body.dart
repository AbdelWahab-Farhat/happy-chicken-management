import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/utils/styles.dart';
import 'package:happy_chicken_restaurant/views/bills/bill_view.dart';
import 'package:happy_chicken_restaurant/views/bills_settlement/bill_settlement_view.dart';
import 'package:happy_chicken_restaurant/views/orders/orders_view.dart';
import '../../../controllers/root_controller/root_cubit.dart';
import '../../home/home_view.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(),
      child: const RootViewBody(),
    );
  }
}

class RootViewBody extends StatelessWidget {
  const  RootViewBody({super.key});

  final List<Widget> _screens = const [
    HomeView(),
    OrdersView(),
    BillView(),
    BillSettlementView()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: _screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => context.read<RootCubit>().changeTab(index),
            selectedItemColor: context.colorScheme.primary,
            selectedLabelStyle: Styles.styles16(context),
            unselectedLabelStyle: Styles.styles16(context),
            unselectedItemColor: context.colorScheme.onSurface.withValues(alpha: 0.4),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "الرئيسية",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_outlined),
                label: "الطلبات",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined),
                label: "الفواتير ",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2_outlined),
                label: "التسويات ",
              ),
            ],
          ),
        );
      },
    );
  }
}
