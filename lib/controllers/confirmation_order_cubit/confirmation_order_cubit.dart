import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/order_services/confirmation_order.dart';
import '../../utils/enums/enum_order_status.dart';

part 'confirmation_order_state.dart';

class ConfirmationOrderCubit extends Cubit<ConfirmationOrderState> {
  EnumOrderStatus? orderStatusAfterConfirmation;
  ConfirmationOrderCubit() : super(ConfirmationOrderInitial());

  Future<void> confirmationOrder(
      String orderId, EnumOrderStatus orderStatus) async {
    emit(ConfirmationOrderLoading());
    var result = await ConfirmationOrder(orderId: orderId)
        .confirmationOrder(orderStatus);
    result.fold((message) => emit(ConfirmationOrderFailure(message)),
        (message) => emit(ConfirmationOrderSuccess(message)));
  }
}
