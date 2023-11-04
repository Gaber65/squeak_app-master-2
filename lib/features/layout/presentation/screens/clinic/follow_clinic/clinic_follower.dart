import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/features/availability/presentation/control/availabilities/availabilities_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/add_clinic/edit_clinic.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import 'package:squeak/features/setting/profile/presentation/pages/doctor_posts.dart';
import 'package:squeak/features/social_media/presentation/screens/chat.dart';

import '../../../../../../core/network/end-points.dart';
import '../../../../../../core/resources/constants_manager.dart';
import '../../../../../../core/service/service_locator.dart';
import '../../../../../../core/widgets/components/styles.dart';
import '../../../../../availability/presentation/components/selver_box.dart';
import '../../../../../availability/presentation/components/silver_header.dart';
import '../../../../../availability/presentation/components/whatsAppBar.dart';

import '../../../../../availability/presentation/page/Availability/get_availabilities.dart';
import '../../../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../../../domain/entites/clinic/all_clinic_follower.dart';
import '../../../../domain/entites/clinic/all_clinics_entities.dart';
import '../../../../layout.dart';

class ClinicFollower extends StatefulWidget {
  ClinicFollower({Key? key, required this.clinicId, required this.clinics})
      : super(key: key);
  String clinicId;
  Clinics clinics;

  @override
  State<ClinicFollower> createState() => _ClinicFollowerState();
}

class _ClinicFollowerState extends State<ClinicFollower> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ClinicCubit>()
        ..getAllFollowersClinics(clinicName: widget.clinicId),
      child: BlocConsumer<ClinicCubit, ClinicState>(
        listener: (context, state) {
          if (state is BlockUserClinicSuccess) {
            ClinicCubit.get(context)
                .getAllFollowersClinics(clinicName: widget.clinicId);
          }

          if (state is DeleteClinicSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const DoctorPost(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          var cubit = ClinicCubit.get(context);

          List<Widget> screens = [
            (state is SqueakGetAllClinicFollowerSuccessState ||
                    cubit.allClinicFollowerEntities != null)
                ? buildBody(
                    context,
                    ClinicCubit.get(context).allClinicFollowerEntities!.data!,
                    cubit)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            GetAvailabilities(
                clinicId: widget.clinicId, clinics: widget.clinics),
          ];

          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverHeader(widget: widget),
                  SliverToBox(widget: widget, cubit: cubit),
                  WhatsappProfileBody(list: screens[cubit.currentIndex])
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody(
      context, AllFollowerData allFollowerData, ClinicCubit cubit) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildDetailsContent(
            context,
            ClinicCubit.get(context)
                .allClinicFollowerEntities!
                .data!
                .followers[index],
            cubit);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12,
        );
      },
      itemCount: ClinicCubit.get(context)
          .allClinicFollowerEntities!
          .data!
          .followers
          .length,
    );
  }

  Widget _buildDetailsContent(context, Followers followers, ClinicCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
          key: UniqueKey(),
          background: Container(
            color: appColorBtn,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    isArabic() ? 'بلوك' : "Block",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
          child: InkWell(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: !BreedsTypeCubit.get(context).isDark
                        ? Colors.white
                        : Colors.grey.shade900,
                    title: Text(isArabic() ? 'حظر المستخدم' : "Block User"),
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width + 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                followers.fullName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'bold', fontSize: 15),
                              ),
                              const Spacer(),
                              CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  '$imageUrl${followers.image}',
                                ),
                                radius: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.green,
                            backgroundColor:
                                Colors.green.shade100.withOpacity(.4),
                            elevation: 0,
                            shape: (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            )),
                          ),
                          child: Text(
                            isArabic() ? 'الغاء' : 'Cancel',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.blockFollowClinics(
                              userId: followers.id,
                              clinicId: widget.clinicId,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red,
                            backgroundColor:
                                Colors.red.shade100.withOpacity(.4),
                            elevation: 0,
                            shape: (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            )),
                          ),
                          child: Text(
                            isArabic() ? 'حظر' : 'block',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatDetail(
                      userId: followers.id,
                      clinicId: widget.clinicId,
                      clinics: widget.clinics,
                      fullName: followers.fullName,
                      image:'',
                    );
                  },
                ),
              );
            },
            child: Card(
              elevation: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              '$imageUrl${followers.image}',
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            followers.fullName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'bold', fontSize: 15),
                          ),
                          const Spacer(),
                          Text(
                            followers.createdAt.toString().substring(0, 10),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'bold', fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          onDismissed: (direction) {
            ClinicCubit.get(context).blockFollowClinics(
                clinicId: widget.clinicId, userId: followers.id);
          },
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: !BreedsTypeCubit.get(context).isDark
                      ? Colors.white
                      : Colors.grey.shade900,
                  title: const Text("Block User"),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width + 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              followers.fullName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'bold', fontSize: 15),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  '$imageUrl${followers.image}'),
                              radius: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green,
                          backgroundColor:
                              Colors.green.shade100.withOpacity(.4),
                          elevation: 0,
                          shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          )),
                        ),
                        child: Text(
                          isArabic() ? 'الغاء' : 'Cancel',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.blockFollowClinics(
                            userId: followers.id,
                            clinicId: widget.clinicId,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.red.shade100.withOpacity(.4),
                          elevation: 0,
                          shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          )),
                        ),
                        child: Text(
                          isArabic() ? 'حظر' : 'block',
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
