import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/order_services/client_location.dart';

part 'google_map_state.dart';

class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit() : super(GoogleMapInitial());

  Future<void> openClientGoogleMaps(double latitude, double longitude) async {
    var result =
        await ClientLocation().openClientGoogleMaps(latitude, longitude);
    result.fold((message) => emit(GoogleMapFailure(message)),
        (value) => emit(GoogleMapSuccess()));
  }
}
