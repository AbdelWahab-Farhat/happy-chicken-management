part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeSuccess extends HomeState {
 final HomeModel homeModel;
  HomeSuccess(this.homeModel);
}
final class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);
}
final class HomeLoading extends HomeState {}