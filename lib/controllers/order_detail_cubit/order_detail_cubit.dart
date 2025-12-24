import 'package:bloc/bloc.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:meta/meta.dart';

import '../../services/order_services/get_order.dart';


part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit() : super(OrderDetailInitial());

  Future<void> getOrderDetail(String id) async {
    emit(OrderDetailLoading());
    var result = await GetOrder(orderId: id).getOrder();
    result.fold((message) => emit(OrderDetailFailure(message)),
        (order) => emit(OrderDetailSuccess(order)));
  }

}
