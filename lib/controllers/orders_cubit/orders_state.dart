part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}
final class OrdersLoading extends OrdersState {}
final class OrdersFailure extends OrdersState {
  final String message;
  OrdersFailure(this.message);
}
final class OrdersSuccess extends OrdersState {
  final List<OrderModel> orders;
  OrdersSuccess(this.orders);
}
