import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:happy_chicken_restaurant/controllers/auth_controller/auth_cubit.dart';
import 'package:meta/meta.dart';

import '../../models/order_model.dart';
import '../../services/bill_services/print_invoice.dart';

part 'print_invoice_state.dart';

class PrintInvoiceCubit extends Cubit<PrintInvoiceState> {
  PrintInvoiceCubit() : super(PrintInvoiceInitial());

  // single Invoice
  Future<void> printInvoice(OrderModel orderModel) async {
    var user = GetIt.I.get<AuthCubit>().userModel;
    emit(PrintInvoiceLoading());
    var result = await PrintInvoice().printInvoice(user!, orderModel);
    result.fold((message) => emit(PrintInvoiceFailure(message: message)),
        (_) => emit(PrintInvoiceSuccess(ordersPrintedIds: [])));
  }

  Future<void> printAllInvoice(List<OrderModel> orderModels) async {
    var user = GetIt.I.get<AuthCubit>().userModel;
    emit(PrintInvoiceLoading());
    var result = await PrintInvoice().printInvoices(user!, orderModels);
    result.fold((message) => emit(PrintInvoiceFailure(message: message)),
        (orderIds) => emit(PrintInvoiceSuccess(ordersPrintedIds: orderIds)));
  }
}
