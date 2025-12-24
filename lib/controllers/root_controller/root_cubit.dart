import 'package:bloc/bloc.dart';



class RootCubit extends Cubit<int> {
  RootCubit([int initialIndex = 0]) : super(initialIndex); // Default index is 0

  void changeTab(int index) {
    emit(index);
  }
}
