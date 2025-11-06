import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/authentication/view/screens/first-rigster-screen.dart';
import 'package:mostakbal/feature/profile-feature/chat-feature/screens/admin/chat-admin.dart';
import 'package:mostakbal/feature/profile-feature/chat-feature/screens/user/all_user_screen.dart';
import 'package:mostakbal/feature/profile-feature/data_source/setting_data_source.dart';
import 'package:mostakbal/feature/profile-feature/view/screens/setting-screen.dart';
import 'package:mostakbal/feature/profile-feature/view/screens/edit-profile-screen.dart';

import '../../controller/setting_cubit.dart';
import '../../controller/setting_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SettingCubit.get(context);

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(240),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Image(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      image: const NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fphoto_6008039178836754286_x.jpg?alt=media&token=3ad0b32a-3125-4a07-97a0-f38a8742d216'),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 100,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 54.0,
                          backgroundImage: NetworkImage(
                            cubit.settingDataSource!.userDataModel!.image,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  cubit.settingDataSource!.userDataModel!.fullName,
                  style: GoogleFonts.tajawal(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  cubit.settingDataSource!.userDataModel!.email,
                  style: GoogleFonts.tajawal(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  userlisttile(context, 'تعديل الملف الشخصي',
                      IconlyLight.profile, IconlyLight.arrow_left_2, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditProfileScreen();
                    }));
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  userlisttile(
                      context,
                      '  الرحلات السابقه',
                      IconlyBroken.ticket_star,
                      IconlyLight.arrow_left_2,
                      () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  userlisttile(
                    context,
                    '  تواصل معنا ',
                    IconlyBroken.message,
                    IconlyLight.arrow_left_2,
                    () {
                      RoutePage().navigateTo(context,(cubit.settingDataSource!.userDataModel!.email != 'adminaccount22@gmail.com') ? AdminChatScreen() :AllUserScreen() );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  userlisttile(
                      context,
                      '   سياسة الخصوصيه',
                      IconlyBroken.shield_done,
                      IconlyLight.arrow_left_2,
                      () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  userlisttile(context, '  الاعدادت', IconlyBroken.setting,
                      IconlyLight.arrow_left_2, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SettingScreen();
                    }));
                  }),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      await SettingDataSource().logOut().then((value) {
                        RoutePage().navigateAndRemove(
                            context, const FirstRegisterScreen());
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          IconlyBroken.logout,
                          color: Colors.red,
                        ),
                        Text(
                          'تسجيل الخروج',
                          style: GoogleFonts.tajawal(
                              color: Colors.red, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget userlisttile(BuildContext context, String title, IconData icon,
      IconData icon2, VoidCallback ontap) {
    return Container(
      color: Colors.transparent,
      height: 40,
      child: ListTile(
        onTap: ontap,
        title: Text(
          title,
          style: FontStyle().textStyle(
              fontColor: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        leading: Icon(
          icon,
          color: Colors.black87,
        ),
        trailing: Icon(icon2),
      ),
    );
  }
}
