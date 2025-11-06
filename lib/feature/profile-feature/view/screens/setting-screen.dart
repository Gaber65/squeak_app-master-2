import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/authentication/view/screens/first-rigster-screen.dart';
import 'package:mostakbal/feature/profile-feature/data_source/setting_data_source.dart';
import 'package:mostakbal/feature/profile-feature/view/screens/change-password-screen.dart';
import 'package:mostakbal/feature/profile-feature/view/screens/lang-screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاعدادت ',
          style:
              GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            userlisttile(context, '   اللغة ', Icons.language,
                IconlyLight.arrow_left_2, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LangugeScreen();
              }));
            }),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 20,
            ),
            userlisttile(context, '    تغيير كلمة المرور',
                IconlyBroken.password, IconlyLight.arrow_left_2, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChangePasswordScreen();
              }));
            }),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 20,
            ),
            userlisttile(context, '  عن الشركة', IconlyBroken.info_square,
                IconlyLight.arrow_left_2, () {}),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                SettingDataSource().deleteAccount().then((value) {
                  RoutePage().navigateAndRemove(context, FirstRegisterScreen());
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconlyBroken.delete,
                    color: Colors.red,
                  ),
                  Text(
                    ' حذف الحساب',
                    style:
                        GoogleFonts.tajawal(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userlisttile(BuildContext context, String title, IconData icon,
      IconData icon2, VoidCallback ontap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: ListTile(
          onTap: ontap,
          title: Text(
            title,
            style: GoogleFonts.tajawal(color: Colors.black87, fontSize: 16),
          ),
          leading: Icon(
            icon,
            color: Colors.black87,
          ),
          trailing: Icon(icon2),
        ),
      ),
    );
  }
}
