import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  TextEditingController searchController = TextEditingController();
  SearchCubit() : super(SearchInitial());
  
  
  void search(String value) {
    searchController.text = value;
  }

  void clear() {
    searchController.clear();
    emit(SearchInitial());
  }
  
  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
