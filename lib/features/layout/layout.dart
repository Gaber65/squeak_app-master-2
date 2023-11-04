import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/network/helper/helper_cubit.dart';
import 'package:squeak/core/resources/constants_manager.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/features/availability/presentation/control/appointments/appointments_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_state.dart';
import 'package:squeak/features/layout/presentation/controller/notification_cubit/notification_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/post_cubit/post_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/home/create_post.dart';

import '../../core/network/helper/connect/internet__cubit.dart';
import '../../core/service/service_locator.dart';
import '../social_media/presentation/controller/phone_cubit/phone_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelperCubit()..getUserData(context: context),
      child: BlocConsumer<HelperCubit, HelperState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return BlocConsumer<SqueakCubit, SqueakState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SqueakCubit.get(context);
              return DefaultTabController(
                length: 4,
                animationDuration: const Duration(milliseconds: 400),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  bottomNavigationBar: TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: appColorBtn,
                    tabs: cubit.items,
                    onTap: (index) {
                      cubit.changeBottomNav(index);
                    },
                  ),
                  body: BlocConsumer<InternetCubit, InternetState>(
                    listener: (context, state) {
                      if (state == InternetState.gained) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isArabic() ? "متصل" : 'Connected'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else if (state == InternetState.lost) {
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text(isArabic() ?"غير متصل":'Not Connected'),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state == InternetState.gained) {
                        // Show your information when connected
                        return cubit.screens[cubit.currentIndex];
                      } else if (state == InternetState.lost) {
                        return Center(
                            child: Image.asset('assets/noInternet.jpg'));
                      } else {
                        return const CircularProgressIndicator(); // Loading indicator
                      }
                    },
                  ),
                  appBar: null,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: sl<SharedPreferences>().getInt('role') == 2
                          ? FloatingActionButton(
                              elevation: 7,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreatePost(
                                        // userImage: cubit.profile!.data!.imageName!,
                                        // username: cubit.profile!.data!.fullName!,
                                        ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.hive,
                              ),
                            )
                          : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
