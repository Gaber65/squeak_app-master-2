import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:squeak/features/layout/presentation/controller/notification_cubit/notification_cubit.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import 'package:squeak/generated/l10n.dart';
import '../../../../core/service/service_locator.dart';
import '../../../social_media/domain/entities/notifications_entities.dart';
import 'package:squeak/core/widgets/components/styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationCubit>()..getNotification(),
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                S.of(context).notifications,
              ),
              centerTitle: true,
            ),
            body: (state is GetNotificationLoading)
                ? FadeIn(
                    duration: const Duration(milliseconds: 400),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade600,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            height: 60,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color:!BreedsTypeCubit.get(context).isDark
                                  ? Colors.blue.shade50
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        },
                        itemCount: 10,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return _buildContent(
                        NotificationCubit.get(context)
                            .notificationModel!
                            .data!
                            .notifications[index],
                        context,
                      );
                    },
                    itemCount: NotificationCubit.get(context)
                        .notificationModel!
                        .data!
                        .notifications
                        .length,
                  ),
          );
        },
      ),
    );
  }

  Widget _buildContent(Notifications model, context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: !BreedsTypeCubit.get(context).isDark
            ? Colors.blue.shade50
            : Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.6,
                              child: Text(
                                model.message,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 15),
                              ),
                            ),
                            Text(
                              model.createdAt.substring(11, 19),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: [
                            Text(
                              model.entityType,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
