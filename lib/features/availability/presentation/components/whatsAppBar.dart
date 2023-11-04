import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/add_clinic/edit_clinic.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';

import '../../../../core/service/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../../layout/domain/entites/clinic/all_clinics_entities.dart';
import '../../../social_media/presentation/screens/chat.dart';
import '../page/Availability/availability_screen.dart';

class WhatsappAppbar extends SliverPersistentHeaderDelegate {
  double screenWidth;
  Tween<double>? profilePicTranslateTween;
  String image;
  String clinicName;
  String clinicId;
  Clinics clinics;
  BuildContext context;
  WhatsappAppbar({
    required this.screenWidth,
    required this.image,
    required this.clinicName,
    required this.clinicId,
    required this.clinics,
    required this.context,
  }) {
    profilePicTranslateTween =
        Tween<double>(begin: screenWidth / 2 - 45 - 40 + 15, end: 40.0);
  }

  static final appbarIconColorTween = ColorTween(
    begin: Colors.grey[800],
    end: Colors.white,
  );

  static final phoneNumberTranslateTween = Tween<double>(begin: 20.0, end: 0.0);

  static final phoneNumberFontSizeTween = Tween<double>(begin: 20.0, end: 16.0);

  static final profileImageRadiusTween = Tween<double>(begin: 3.5, end: 1.0);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final relativeScroll = min(shrinkOffset, 45) / 45;
    final relativeScroll70px = min(shrinkOffset, 70) / 70;
    final appBarColorTween = ColorTween(
      begin: BreedsTypeCubit.get(context).isDark
          ? ThemeData.dark().scaffoldBackgroundColor
          : Colors.white,
      end: appColorBtn,
    );

    return Container(
      color: appBarColorTween.transform(relativeScroll),
      child: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: isArabic()
                      ? const Icon(Icons.arrow_forward, size: 25)
                      : const Icon(Icons.arrow_back, size: 25),
                  color: appbarIconColorTween.transform(relativeScroll),
                ),
              ),
              if (sl<SharedPreferences>().getInt('role') == 2 &&
                  clinics.admin!.id == clintId)
                Positioned(
                  right: 0,
                  child: PopupMenuButton<int>(
                    elevation: 2,
                    shape: (RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    )),
                    onCanceled: () {
                      Navigator.of(context);
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        onTap: () {
                          ClinicCubit.get(context)
                              .deleteClinic(clinicId: clinicId);
                        },
                        child: Row(
                          children: [
                            Text(
                              S.of(context).removeClinic,
                            ),
                            Spacer(),
                            Icon(
                              IconlyLight.delete,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        onTap: () {
                          print('*******');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditClinic(
                                  clinicId: clinicId,
                                  clinics: clinics,
                                ),
                              ));
                        },
                        child: Row(
                          children: [
                            Text(S.of(context).edit),
                            Spacer(),
                            Icon(
                              Icons.edit,
                              color: Colors.green,
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        onTap: () {
                          print('*******');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddAvailability(
                                clinicId: clinicId,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              S.of(context).addAvailabilities,
                            ),
                            Spacer(),
                            Icon(Icons.timer)
                          ],
                        ),
                      ),
                    ],
                    icon: Icon(
                      Icons.more_horiz,
                      size: 25,
                      color: appbarIconColorTween.transform(relativeScroll),
                    ),
                    offset: const Offset(0, 20),
                  ),
                ),
              Positioned(
                  top: 15,
                  left: 90,
                  child: displayPhoneNumber(relativeScroll70px)),
              Positioned(
                  top: 5,
                  left: profilePicTranslateTween!.transform(relativeScroll70px),
                  child: displayProfilePicture(relativeScroll70px, image)),
            ],
          ),
        ],
      ),
    );
  }

  Widget displayProfilePicture(double relativeFullScrollOffset, String image) {
    return Transform(
      transform: Matrix4.identity()
        ..scale(
          profileImageRadiusTween.transform(relativeFullScrollOffset),
        ),
      child: CircleAvatar(
        backgroundImage: NetworkImage("$imageUrl$image"),
      ),
    );
  }

  Widget displayPhoneNumber(double relativeFullScrollOffset) {
    if (relativeFullScrollOffset >= 0.8) {
      return Transform(
        transform: Matrix4.identity()
          ..translate(
            0.0,
            phoneNumberTranslateTween
                .transform((relativeFullScrollOffset - 0.8) * 5),
          ),
        child: Text(
          clinicName,
          style: TextStyle(
            fontSize: phoneNumberFontSizeTween
                .transform((relativeFullScrollOffset - 0.8) * 5),
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(WhatsappAppbar oldDelegate) {
    return true;
  }
}

class WhatsappProfileBody extends StatelessWidget {
  WhatsappProfileBody({Key? key, required this.list}) : super(key: key);
  Widget list;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: list,
          ),
        ],
      ),
    );
  }
}

class ProfileIconButtons extends StatelessWidget {
  ProfileIconButtons({Key? key, required this.clinicId, this.clinics})
      : super(key: key);

  String clinicId;
  Clinics? clinics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ClinicCubit.get(context)
                    .postUnFollowClinics(clinicId: clinicId);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.red.shade100.withOpacity(.4),
                elevation: 0,
                shape: (RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                )),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(IconlyLight.user),
                  Text(
                    isArabic() ? 'الغاء المتابعة' : 'UnFollow',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                print(clinics!.clinicId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetail(
                      clinicId: clinics!.clinicId,
                      clinics:clinics!,
                      userId:clinics!.admin!.id ,
                      fullName: clinics!.name,
                      image: clinics!.image,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.purple,
                backgroundColor: Colors.purple.shade100.withOpacity(.4),
                elevation: 0,
                shape: (RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                )),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(IconlyLight.chat),
                  Text(
                    isArabic() ? 'مراسلة' : 'Massage',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneAndName extends StatelessWidget {
  PhoneAndName({Key? key, required this.speciality, required this.clinicName, required this.phone})
      : super(key: key);
  String speciality;
  String phone;
  String clinicName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 35),
        Text(
          clinicName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          speciality,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          phone,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),

      ],
    );
  }
}
