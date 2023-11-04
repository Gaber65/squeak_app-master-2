import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/features/authentication/login/presentation/controller/cubit/login_cubit.dart';
import 'package:squeak/features/layout/layout.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/add_clinic/add_clinic.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';

import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entites/clinic/all_clinics_entities.dart';
import '../../controller/post_cubit/post_cubit.dart';
import '../clinic/add_clinic/edit_clinic.dart';
import '../clinic/follow_clinic/clinic_follower.dart';
import '../nav/specialistInfoPage.dart';

class FollowerScreen extends StatelessWidget {
  const FollowerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ClinicCubit>()..geMyFollowerClinic(),
      child: BlocConsumer<ClinicCubit, ClinicState>(
        listener: (context, state) {
          if (state is SqueakFollowSuccessState) {
            ClinicCubit.get(context)
                .clinicFollowersEntities!
                .data!
                .clinics
                .clear();
            ClinicCubit.get(context).geMyFollowerClinic();
          }
        },
        builder: (context, state) {
          var cubit = ClinicCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).yourClinic,
              ),
              centerTitle: false,
              actions: [
                MaterialButton(
                  minWidth: 20,
                  elevation: 0,
                  onPressed: () {
                    cubit.changeSelect();
                  },
                  child: Icon(
                    Icons.grid_view_rounded,
                    color:
                        !cubit.isGridView ? Colors.red.shade900 : Colors.black,
                  ),
                ),
                MaterialButton(
                  minWidth: 20,
                  elevation: 0,
                  onPressed: () {
                    cubit.changeSelect();
                  },
                  child: Icon(
                    Icons.horizontal_split,
                    color:
                        cubit.isGridView ? Colors.red.shade900 : Colors.black,
                  ),
                ),
              ],
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(5),
                  child: (state is SqueakFollowLoadingState)
                      ? const LinearProgressIndicator()
                      : const SizedBox()),
            ),
            body: BlocConsumer<ClinicCubit, ClinicState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Column(
                  children: [
                    (state is GetFollowerClinicLoadingState)
                        ? cubit.isGridView
                            ? Expanded(
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 400),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade600,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 60,
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: !BreedsTypeCubit.get(context)
                                                    .isDark
                                                ? Colors.blue.shade50
                                                : Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        );
                                      },
                                      itemCount: 10,
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 400),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade600,
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        mainAxisExtent: 280.0,
                                        maxCrossAxisExtent: 222.0,
                                      ),
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 60,
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: !BreedsTypeCubit.get(context)
                                                    .isDark
                                                ? Colors.blue.shade50
                                                : Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        );
                                      },
                                      itemCount: 10,
                                    ),
                                  ),
                                ),
                              )
                        : const SizedBox(),
                    if (state is! GetFollowerClinicLoadingState)
                      if (cubit.clinicFollowersEntities != null &&
                          cubit.clinicFollowersEntities!.data!.clinics.isEmpty)
                        Center(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://img.freepik.com/free-vector/social-media-isometric-concept-with-notification-icons-smartphone-characters-followers_1284-63085.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.131510781.1692744483&semt=ais',
                          ),
                        ),
                    if (cubit.clinicFollowersEntities != null &&
                        cubit.clinicFollowersEntities!.data!.clinics.isNotEmpty)
                      (cubit.isGridView)
                          ? Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return buildDetailsContent(
                                    cubit.clinicFollowersEntities!.data!
                                        .clinics[index].clinic,
                                    context,
                                    index,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                itemCount: cubit.clinicFollowersEntities!.data!
                                    .clinics.length,
                              ),
                            )
                          : Expanded(
                              child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 280.0,
                                  maxCrossAxisExtent: 222.0,
                                ),
                                itemBuilder: (context, index) {
                                  return buildPaddingWatch(
                                      context,
                                      cubit.clinicFollowersEntities!.data!
                                          .clinics![index].clinic);
                                },
                                itemCount: cubit.clinicFollowersEntities!.data!
                                    .clinics.length,
                              ),
                            ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildDetailsContent(Clinics clinics, context, index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          print(clintId);
          print(clinics.admin!.id);

          if (sl<SharedPreferences>().getInt('role') == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SpecialistInfoPage(
                  nameDoctor: clinics.name,
                  clinics: clinics,
                ),
              ),
            );
          }

          if (clinics.admin!.id == clintId &&
              sl<SharedPreferences>().getInt('role') == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClinicFollower(
                  clinicId: clinics.clinicId,
                  clinics: clinics,
                ),
              ),
            );
          } else if (SqueakCubit.get(context).profile!.data!.role == 2 &&
              clinics.admin!.id != clintId) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SpecialistInfoPage(
                  nameDoctor: clinics.name,
                  clinics: clinics,
                ),
              ),
            );
          }
        },
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${S.of(context).name}        : \t',
                            style: FontStyle()
                                .textStyle(fontSize: 12, color: appColorBtn),
                          ),
                          Flexible(
                            child: Text(
                              clinics.name,
                              style: FontStyle().textStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            '${S.of(context).speciality} : \t',
                            style: FontStyle()
                                .textStyle(fontSize: 12, color: appColorBtn),
                          ),
                          Flexible(
                            child: Text(
                              clinics.speciality.first.name,
                              overflow: TextOverflow.ellipsis,
                              style: FontStyle().textStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: appColorBtn,
                            size: 14,
                          ),
                          Flexible(
                            child: Text(
                              '${clinics.address},\t\t${clinics.city},\t\t${clinics.location}'!,
                              style: FontStyle().textStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            '$imageUrl${clinics.image}'),
                        radius: 25,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CircleAvatar(
                        backgroundColor: appColorBtn,
                        radius: 15,
                        child: IconButton(
                          iconSize: 15,
                          onPressed: () {
                            ClinicCubit.get(context).postUnFollowClinics(
                                clinicId: clinics.clinicId);
                          },
                          icon: const Icon(Icons.person_add_disabled),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPaddingWatch(BuildContext context, Clinics model) {
    return InkWell(
      onTap: () {
        print(clintId);
        print(model.admin!.id);

        if (SqueakCubit.get(context).profile!.data!.role == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpecialistInfoPage(
                nameDoctor: model.name,
                clinics: model,
              ),
            ),
          );
        }

        if (model.admin!.id == clintId &&
            SqueakCubit.get(context).profile!.data!.role == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClinicFollower(
                clinicId: model.clinicId,
                clinics: model,
              ),
            ),
          );
        } else if (SqueakCubit.get(context).profile!.data!.role == 2 &&
            model.admin!.id != clintId) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpecialistInfoPage(
                nameDoctor: model.name,
                clinics: model,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          surfaceTintColor: Colors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        '$imageUrl${model.image}',
                        width: 161,
                        height: 127,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CircleAvatar(
                        radius: 13,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ClinicCubit.get(context)
                                .postUnFollowClinics(clinicId: model.clinicId);
                          },
                          icon: const Icon(
                            Icons.person_add_disabled,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${S.of(context).name}        : ',
                              style: FontStyle()
                                  .textStyle(fontSize: 12, color: appColorBtn),
                            ),
                            Flexible(
                              child: Text(
                                model.name,
                                style: FontStyle().textStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${S.of(context).speciality} : ',
                              style: FontStyle()
                                  .textStyle(fontSize: 12, color: appColorBtn),
                            ),
                            Flexible(
                              child: Text(
                                model.speciality.first.name,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyle().textStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: appColorBtn,
                              size: 14,
                            ),
                            Flexible(
                              child: Text(
                                '${model.address}'!,
                                style: FontStyle().textStyle(
                                  fontSize: 12,
                                ),
                              ),
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
        ),
      ),
    );
  }
}
