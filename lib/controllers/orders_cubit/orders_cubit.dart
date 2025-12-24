import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

import '../../models/order_model.dart';
import '../../services/order_services/get_orders.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<PagingState<int, OrderModel>> {
  final List<String> states;
  OrdersCubit(this.states) : super(PagingState());

  Future<void> fetchNextOrderPage(int key, String searchQuery) async {
    if (state.isLoading) return;
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, error: null));
    }
      final result = await GetOrders().getOrders(key, states, searchQuery: searchQuery);
      result.fold(
        (message) {
          if (!isClosed) {
            emit(state.copyWith(isLoading: false, error: message));
          }
        },
        (orders) {
          final isLastPage = orders.isEmpty;
          if (!isClosed) {
            final newKey = key + 1;
            emit(state.copyWith(
              keys: [...?state.keys, newKey],
              pages: [...?state.pages, orders],
              hasNextPage: !isLastPage,
              isLoading: false,
            ));
          }
        },
      );
  }

  void clear() {
    emit(state.copyWith(
      pages: null,
      keys: null,
      hasNextPage: true,
    ));
  }

}
