import 'package:bloc/bloc.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/services/bill_services/send_printed_orders.dart';
import 'package:meta/meta.dart';

import '../../services/bill_services/get_orders_for_print.dart';

part 'bills_settlement_state.dart';

class BillsSettlementCubit extends Cubit<BillsSettlementState> {
  BillsSettlementCubit() : super(BillsSettlementInitial());
  Future<void> getAllOrdersToPrint() async {
    emit(BillsSettlementLoading());
    var result = await GetOrdersForPrint().getOrdersForPrint();
    result.fold((message) => emit(BillsSettlementFailure(message)), (orders) {
      emit(BillsSettlementSuccess(orders));
    });
  }

  Future<void> sendAllOrderPrintedIdsToBackend(List<String> orderIds) async {
    emit(BillsSettlementLoading());
    var result = await SendPrintedOrders().sendPrintedOrders(orderIds);
    result.fold((message) => emit(BillsSettlementFailure(message)), (message) {
      emit(BillsSettlementPrintSuccess(message));
    });
  }
}
