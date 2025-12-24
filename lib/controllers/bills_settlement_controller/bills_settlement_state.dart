part of 'bills_settlement_cubit.dart';

@immutable
sealed class BillsSettlementState {}

final class BillsSettlementInitial extends BillsSettlementState {}
final class BillsSettlementSuccess extends BillsSettlementState {
  final List<OrderModel> orders;
  BillsSettlementSuccess(this.orders);
}
final class BillsSettlementFailure extends BillsSettlementState {
  final String message;
  BillsSettlementFailure(this.message);
}
final class BillsSettlementLoading extends BillsSettlementState {}

final class BillsSettlementPrintSuccess extends BillsSettlementState {
  final String message;
  BillsSettlementPrintSuccess(this.message);
}