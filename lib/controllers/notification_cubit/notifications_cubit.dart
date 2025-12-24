import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:happy_chicken_restaurant/models/notification_model.dart';
import 'package:happy_chicken_restaurant/services/notifications_services/get_notifications.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';



class NotificationsCubit extends Cubit<PagingState<int, NotificationModel>> {
  NotificationsCubit() : super(PagingState());
  Future<void> fetchNextNotificationPage(int key) async {
    if (state.isLoading) return;
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, error: null));
    }
    try {
      final result =
          await GetNotifications().getNotifications(key);
      result.fold(
        (message) {
          if (!isClosed) {
            emit(state.copyWith(isLoading: false, error: message));
          }
        },
        (notifications) {
          final isLastPage = notifications.isEmpty;
          if (!isClosed) {
            final newKey = key + 1;
            emit(state.copyWith(
              keys: [...?state.keys, newKey],
              pages: [...?state.pages, notifications],
              hasNextPage: !isLastPage,
              isLoading: false,
            ));
          }
        },
      );
    } catch (error) {
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, error: error.toString()));
      }
    }
  }

  void clear() {
    emit(state.copyWith(
      pages: null,
      keys: null,
      hasNextPage: true,
    ));
  }

}
