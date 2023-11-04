import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/network/helper/helper_cubit.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/features/layout/domain/entites/clinic/all_clinics_entities.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/social_media/domain/entities/create_message_entities.dart';
import 'package:squeak/features/social_media/presentation/components/build_Message_compoment.dart';
import 'package:squeak/features/social_media/presentation/controller/chat_cubit.dart';

import '../../../../core/service/service_locator.dart';
import '../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../components/send_option_components.dart';

class ChatDetail extends StatelessWidget {
  String userId;
  String clinicId;
  String fullName;
  Clinics clinics;
  String image;
  ChatDetail({
    super.key,
    required this.userId,
    required this.clinicId,
    required this.fullName,
    required this.image,
    required this.clinics,
  });

  var messageController = TextEditingController();
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    print(clinicId);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            if (sl<SharedPreferences>().getInt('role') == 2 &&
                clinics.admin!.id ==
                    sl<SharedPreferences>().getString('clintId')) {
              return sl<ChatCubit>()
                ..getAllAdminMassage(
                  clinicId: clinicId,
                  userId: userId,
                );
            } else {
              return sl<ChatCubit>()
                ..getAllUserMassage(
                  clinicId: clinicId,
                );
            }
          },
        ),
        BlocProvider(
          create: (context) => sl<HelperCubit>(),
        ),
      ],
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is SendMessageSuccessState) {
            if (state.createMessageEntities!.success!) {
              if (sl<SharedPreferences>().getInt('role') == 2 &&
                  clinics.admin!.id ==
                      sl<SharedPreferences>().getString('clintId')) {
                ChatCubit.get(context).adminMassagesModel.clear();
                ChatCubit.get(context).allAdminPageNumber = 1;

                ChatCubit.get(context).getAllAdminMassage(
                  userId: userId,
                  clinicId: clinicId,
                );
              } else {
                ChatCubit.get(context).userMassagesModel.clear();
                ChatCubit.get(context).allUserPageNumber = 1;
                ChatCubit.get(context).getAllUserMassage(clinicId: clinicId);
              }
            }
          }

          if (state is MessagePickedImageSuccessState) {
            HelperCubit.get(context).getGlobalImage(
              file: state.file,
              uploadPlace: UploadPlace().messageImage,
            );
          }
          if (state is MessagePickedSoundSuccessState) {
            HelperCubit.get(context).getGlobalSound(
              file: state.file,
              uploadPlace: UploadPlace().messageRecord,
            );
          }
        },
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          print(clinicId);

          return Scaffold(
            body: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: !BreedsTypeCubit.get(context).isDark
                      ? 'https://i.pinimg.com/564x/c9/2a/1b/c92a1bc1de0ebfd48d39538bd321e291.jpg'
                      : 'https://i.pinimg.com/564x/5a/11/bb/5a11bb1d77ee734b4f16ad3b2d6bc189.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
                Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      title: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider('$imageUrl$image'),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            fullName,
                          ),
                        ],
                      ),
                    ),
                    if (sl<SharedPreferences>().getInt('role') == 2 && clinics.admin!.id == sl<SharedPreferences>().getString('clintId') && cubit.adminMassages.isNotEmpty)
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification.metrics.pixels ==
                                    notification.metrics.minScrollExtent &&
                                notification is ScrollUpdateNotification) {
                              cubit.getAllAdminMassage(
                                pagination: true,
                                clinicId: clinicId,
                                userId: userId,
                              );
                            }
                            return true;
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (cubit.adminMassages[index].toUserId != null) {
                                return buildMyMessage(
                                  cubit.adminMassages[index],
                                  context,
                                );
                              } else {
                                return buildMessage(
                                  cubit.adminMassages[index],
                                  context,
                                );
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: cubit.adminMassages.length,
                          ),
                        ),
                      ),
                    if (sl<SharedPreferences>().getInt('role') == 1 &&
                        cubit.userMassages.isNotEmpty)
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification.metrics.pixels ==
                                    notification.metrics.minScrollExtent &&
                                notification is ScrollUpdateNotification) {
                              cubit.getAllAdminMassage(
                                pagination: true,
                                clinicId: clinicId,
                                userId: userId,
                              );
                            }
                            return true;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (cubit.userMassages[index].toUserId ==
                                    null) {
                                  return buildMyMessage(
                                    cubit.userMassages[index],
                                    context,
                                  );
                                } else {
                                  return buildMessage(
                                    cubit.userMassages[index],
                                    context,
                                  );
                                }
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: cubit.userMassages.length,
                            ),
                          ),
                        ),
                      ),
                    if (sl<SharedPreferences>().getInt('role') == 2 &&
                        cubit.userMassages.isNotEmpty)
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification.metrics.pixels ==
                                    notification.metrics.minScrollExtent &&
                                notification is ScrollUpdateNotification) {
                              cubit.getAllAdminMassage(
                                pagination: true,
                                clinicId: clinicId,
                                userId: userId,
                              );
                            }
                            return true;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (cubit.userMassages[index].toUserId !=
                                    null) {
                                  return buildMyMessage(
                                    cubit.userMassages[index],
                                    context,
                                  );
                                } else {
                                  return buildMessage(
                                    cubit.userMassages[index],
                                    context,
                                  );
                                }
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: cubit.userMassages.length,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: AppSize.s70,
                    ),
                  ],
                ),
              ],
            ),
            floatingActionButton: BuildOptionSend(
              messageController: messageController,
              context: context,
              toUserId: userId,
              cubit: cubit,
              clinicId: clinicId,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
