part of 'google_map_cubit.dart';

@immutable
sealed class GoogleMapState {}

final class GoogleMapInitial extends GoogleMapState {}
final class GoogleMapLoading extends GoogleMapState {}
final class GoogleMapFailure extends GoogleMapState {
  final String message;
  GoogleMapFailure(this.message);
}
final class GoogleMapSuccess extends GoogleMapState {}
