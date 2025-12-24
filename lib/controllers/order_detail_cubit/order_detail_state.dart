part of 'order_detail_cubit.dart';

@immutable
sealed class OrderDetailState {}

final class OrderDetailInitial extends OrderDetailState {}
final class OrderDetailLoading extends OrderDetailState {}
final class OrderDetailFailure extends OrderDetailState {
  final String message;
  OrderDetailFailure(this.message);
}
final class OrderDetailSuccess extends OrderDetailState {
  final OrderModel orderModel;

  OrderDetailSuccess( this.orderModel);
}
