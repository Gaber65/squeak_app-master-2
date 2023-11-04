import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/service/service_locator.dart';
import 'package:squeak/features/availability/presentation/control/appointments/appointments_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/notification_cubit/notification_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/post_cubit/post_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/add_edit_beets_cubit.dart';
import 'package:squeak/features/social_media/presentation/controller/phone_cubit/phone_cubit.dart';

import '../../features/authentication/login/presentation/pages/login.dart';
import '../../features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';

class Constants {
  void signOut(context) async {
    sl<SharedPreferences>().remove('token');
    sl<SharedPreferences>().remove('clintId');
    sl<SharedPreferences>().remove('uId');
    sl<SharedPreferences>().remove('isDark');
    sl<SharedPreferences>().remove('language');
    sl<SharedPreferences>().remove('refreshToken');

    await FirebaseMessaging.instance.deleteToken();
    await FirebaseAuth.instance.signOut().then(
      (value) {
        BreedsTypeCubit.get(context).changeAppMode(fromShared: false);
        BreedsTypeCubit.get(context).isDark = false;
        SqueakCubit.get(context).profile = null;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
    );
  }

  // Future<void> getMethods(context) async {
  //   /// SQueak
  //   SqueakCubit.get(context).getOwnerPits();
  //   SqueakCubit.get(context).getProfile();
  //
  //   AddBeetsCubit.get(context).getAllSpecies();
  //   BreedsTypeCubit.get(context).getOwnerPits();
  //
  //   NotificationCubit.get(context).getNotification();
  //
  //   /// Clinic
  //   ClinicCubit.get(context).getFollowersToClinic();
  //   ClinicCubit.get(context).getAllSpeciality();
  //   ClinicCubit.get(context).getAllSupplierClinics();
  //
  //   /// post
  //
  //   PostCubit.get(context).getDoctorPost();
  //   AppointmentsCubit.get(context).getDoctorAppointments();
  //
  //   PostCubit.get(context).getPost();
  //   AppointmentsCubit.get(context).getAppointments();
  //
  //   ///user Data
  //   PhoneCubit.get(context).getUserData();
  //
  //   ///Notification data
  //   NotificationCubit.get(context).getNotification();
  // }
}
