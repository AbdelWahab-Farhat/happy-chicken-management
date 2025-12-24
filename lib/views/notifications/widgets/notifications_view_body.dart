import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_chicken_restaurant/controllers/notification_cubit/notifications_cubit.dart';
import 'package:happy_chicken_restaurant/models/notification_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/utils/styles.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NotificationsCubit>();

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'الإشعارات',
        style: Styles.styles16(context),
      )),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: BlocBuilder<NotificationsCubit,
                PagingState<int, NotificationModel>>(
              builder: (context, state) {
                return PagedSliverList(
                    state: state,
                    fetchNextPage: () => cubit.fetchNextNotificationPage(state.keys?.last ?? 1),
                    builderDelegate:
                        PagedChildBuilderDelegate<NotificationModel>(
                            itemBuilder: (context, item, index) {
                              return NotificationItem(
                                model: item,
                              );
                            },
                            firstPageErrorIndicatorBuilder: (context) => Center(
                                  child: Text(
                                    state.error.toString() ??
                                        "خطاء في تحميل البيانات",
                                    style: Styles.styles20(context),
                                  ),
                                ),
                            noItemsFoundIndicatorBuilder: (context) => Center(
                                  child: Text(
                                    "لا توجد اشعارات حالياً",
                                    style: Styles.styles20(context),
                                  ),
                                )));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationModel model;
  const NotificationItem({
    super.key,
    required this.model,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          model.message ?? "لا يوجد",
          style: Styles.styles16(context),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 8),
            // Text(
            //   model.description ?? "لا يوجد",
            //   style: Styles.styles16(context).copyWith(fontSize: 14),
            // ),
            // const SizedBox(height: 8),
            // Align(
            //   alignment: AlignmentDirectional.bottomEnd,
            //   child: Text(
            //     model.date ?? "لا يوجد",
            //     style: Styles.styles16(context).copyWith(fontSize: 12),
            //   ),
            // ),
          ],
        ),
        leading: model.isRead
            ? Icon(Icons.notifications_active_rounded,
                color: context.colorScheme.primary)
            : SizedBox(),
      ),
    );
  }
}
