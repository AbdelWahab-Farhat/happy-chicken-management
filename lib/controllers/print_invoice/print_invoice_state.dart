part of 'print_invoice_cubit.dart';

@immutable
sealed class PrintInvoiceState {}

final class PrintInvoiceInitial extends PrintInvoiceState {}
final class PrintInvoiceLoading extends PrintInvoiceState {}
final class PrintInvoiceSuccess extends PrintInvoiceState {
  final List<String> ordersPrintedIds;
  PrintInvoiceSuccess({required this.ordersPrintedIds});
}
final class PrintInvoiceFailure extends PrintInvoiceState {
  final String message;
  PrintInvoiceFailure({required this.message});
}
