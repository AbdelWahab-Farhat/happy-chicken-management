import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/home_model.dart';
import '../../services/home_services/get_home_static_info.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());


  Future<void> getHomeStaticInfo() async {
    emit(HomeLoading());

    var result = await GetHomeStaticInfo().getHomeStaticInfo();
    if (!isClosed) {
      result.fold(
            (message) => emit(HomeFailure(message)),
            (homeModel) => emit(HomeSuccess(homeModel)),
      );
    }
  }
}