part of 'confirmation_order_cubit.dart';

@immutable
sealed class ConfirmationOrderState {}

final class ConfirmationOrderInitial extends ConfirmationOrderState {}
final class ConfirmationOrderFailure extends ConfirmationOrderState {
  final String message;
  ConfirmationOrderFailure(this.message);
}
final class ConfirmationOrderSuccess extends ConfirmationOrderState {
  final String message;
  ConfirmationOrderSuccess(this.message);
}
final class ConfirmationOrderLoading extends ConfirmationOrderState {}
