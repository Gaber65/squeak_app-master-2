import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/resources/strings_manager.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/core/widgets/text_btn.dart';
import 'package:squeak/features/layout/build_layout.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/post_cubit/post_cubit.dart';

import '../../../../../core/network/end-points.dart';
import '../../../../../core/resources/constants_manager.dart';

import '../../../../../generated/l10n.dart';
import '../../../../availability/presentation/page/appointments/doctor_appointment.dart';
import '../../../../layout/presentation/controller/Home_cubit/squeak_state.dart';
import '../../../../layout/presentation/screens/clinic/add_clinic/add_clinic.dart';
import '../../../../layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import '../../../../social_media/presentation/screens/chat.dart';
import '../../../update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../../update_profile/presentation/pages/my_pets.dart';
import '../../../update_profile/presentation/widgets/build_update_profile.dart';
import 'contact_us.dart';
import 'doctor_posts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    SqueakCubit.get(context).getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SqueakCubit, SqueakState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SqueakCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).profile),
            elevation: 4,
            actions: [
              Row(
                children: [
                  const Icon(
                    IconlyBold.edit,
                    color: appColorBtn,
                  ),
                  MyTextButton(
                    onPressed: () {
                      print(cubit.profile!.data!.phone);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuildUpdateProfile(
                            model: cubit.profile!,
                          ),
                        ),
                      );
                    },
                    text: S.of(context).edit,
                    colors: ColorManager.lightRed,
                  ),
                ],
              )
            ],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )),
            bottom: PreferredSize(
              preferredSize: (sl<SharedPreferences>().getInt('role') == 2)
                  ? const Size(double.infinity, 190)
                  : const Size(double.infinity, 150),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          backgroundImage: (cubit.profile != null)
                              ? CachedNetworkImageProvider(
                                  '$imageUrl${cubit.profile!.data!.imageName}')
                              : const CachedNetworkImageProvider(''),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (cubit.profile != null)
                                ? Text(
                                    cubit.profile!.data!.fullName!,
                                    style: const TextStyle(fontSize: 16),
                                  )
                                : const Text(
                                    'User 1',
                                    style: TextStyle(fontSize: 16),
                                  ),
                            Row(
                              children: [
                                (cubit.profile != null)
                                    ? Text(
                                        cubit.profile!.data!.userName!,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      )
                                    : const Text(
                                        'SDF8FS8120SDF8FS8120',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: cubit.profile!.data!.userName));
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (sl<SharedPreferences>().getInt('role') == 1)
                      const SizedBox(
                        height: 12,
                      ),
                    if (sl<SharedPreferences>().getInt('role') == 2)
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DoctorPost(),
                                  ),
                                );
                              },
                              child: TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText:
                                      isArabic() ? 'الانشطه' : 'Activity ',
                                  suffixIcon: const Icon(Icons.category),
                                  disabledBorder: const UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(
              AppPadding.p10,
            ),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.pets,
                          color: ColorManager.lightRed,
                        )),
                    title: Text(S.of(context).myPets),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // cat 1
                          builder: (context) => const MyPets(),
                        ),
                      );
                    },
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                if (sl<SharedPreferences>().getInt('role') == 2)
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                          backgroundColor: backgroundColor,
                          child: Icon(
                            IconlyLight.category,
                            color: ColorManager.lightRed,
                          )),
                      title: Text(
                        S.of(context).addPetService,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddClinic(),
                          ),
                        );
                      },
                      trailing: const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.share,
                          color: ColorManager.lightRed,
                        )),
                    title: Text(
                      S.of(context).inviteFriends,
                    ),
                    onTap: () {
                      Share.share('check out my website https://example.com');
                    },
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          BreedsTypeCubit.get(context).isDark
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          color: ColorManager.lightRed,
                        )),
                    title: Text(
                      S.of(context).darkMode,
                    ),
                    trailing: Switch(
                      value: BreedsTypeCubit.get(context).isDark,
                      onChanged: (value) {
                        BreedsTypeCubit.get(context).changeAppMode();
                      },
                    ),
                  ),
                ),
                Card(
                  child: PopupMenuButton<int>(
                    onCanceled: () {
                      Navigator.of(context);
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 1,
                          onTap: () {
                            BreedsTypeCubit.get(context)
                                .changeAppLang(langMode: 'ar');
                            print(BreedsTypeCubit.get(context).language);
                          },
                          child: const Text(
                            'اللغة العربية',
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          onTap: () {
                            BreedsTypeCubit.get(context)
                                .changeAppLang(langMode: 'en');
                            print(BreedsTypeCubit.get(context).language);
                          },
                          child: const Text(
                            'English language',
                          ),
                        ),
                      ];
                    },
                    child: ListTile(
                        leading: const CircleAvatar(
                            backgroundColor: backgroundColor,
                            child: Icon(
                              Icons.language,
                              color: ColorManager.lightRed,
                            )),
                        title: Text(
                          S.of(context).langMode,
                        ),
                        trailing: PopupMenuButton<int>(
                          onCanceled: () {
                            Navigator.of(context);
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 1,
                                onTap: () {
                                  BreedsTypeCubit.get(context)
                                      .changeAppLang(langMode: 'ar');
                                  print(BreedsTypeCubit.get(context).language);
                                },
                                child: const Text(
                                  'اللغة العربية',
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                onTap: () {
                                  BreedsTypeCubit.get(context)
                                      .changeAppLang(langMode: 'en');
                                  print(BreedsTypeCubit.get(context).language);
                                },
                                child: const Text(
                                  'English language',
                                ),
                              ),
                            ];
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down_rounded,
                          ),
                          offset: const Offset(0, 20),
                        )),
                  ),
                ),
                if (sl<SharedPreferences>().getInt('role') == 2)
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.av_timer,
                          color: ColorManager.lightRed,
                        ),
                      ),
                      title: Text(S.of(context).yourAppointments),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // cat 1
                            builder: (context) => const DoctorAppointment(),
                          ),
                        );
                      },
                      trailing: const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          Icons.help_outline,
                          color: ColorManager.lightRed,
                        )),
                    title: Text(
                      S.of(context).help,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // cat 1
                          builder: (context) => ContactUsScreen(),
                        ),
                      );
                    },
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                // Card(
                //   child: ListTile(
                //     leading: const CircleAvatar(
                //         backgroundColor: backgroundColor,
                //         child: Icon(
                //           Icons.settings_outlined,
                //           color: ColorManager.lightRed,
                //         )),
                //     title: const Text(
                //       AppStrings.settings,
                //     ),
                //     onTap: () {},
                //     trailing: const Icon(
                //       Icons.chevron_right,
                //     ),
                //   ),
                // ),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        child: Icon(
                          IconlyLight.logout,
                          color: ColorManager.lightRed,
                        )),
                    title: Text(
                      S.of(context).signOut,
                    ),
                    onTap: () {
                      Constants().signOut(context);
                    },
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
