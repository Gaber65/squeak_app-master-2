import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/const/const.dart';
1import 'package:mostakbal/feature/home_page/home_feeds/controller/home_cubit.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_state.dart';
import 'package:mostakbal/feature/profile-feature/controller/setting_cubit.dart';

import '../../fav-feature/controller/fav_cubit.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()
            ..getBannar()
            ..getForYouData()
            ..getDomesticTourism()
            ..getForeignTourism()
            ..getHajjAndUmrah()
            ..getOffer(),
        ),
        BlocProvider(create: (context) => SettingCubit()..getUserData()),
        BlocProvider(
          create: (context) => FavCubit()..getToFav(),
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          var settingCubit = SettingCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: buildCurvedNavigationBar(cubit),
            body: (settingCubit.settingDataSource.userDataModel != null)
                ? cubit.screens[cubit.currentIndex]
                : const Center(
                    child: LinearProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }

  CurvedNavigationBar buildCurvedNavigationBar(HomeCubit cubit) {
    return CurvedNavigationBar(
      animationDuration: const Duration(milliseconds: 300),
      index: cubit.currentIndex,
      color: Colors.white,
      backgroundColor: Colors.white,
      buttonBackgroundColor: ColorStyle().primaryColor,
      height: 75,
      animationCurve: Curves.ease,
      items: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            IconlyLight.home,
            size: 24,
            color: cubit.currentIndex == 0 ? Colors.white : Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            IconlyLight.ticket,
            size: 24,
            color: cubit.currentIndex == 1 ? Colors.white : Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            IconlyLight.heart,
            size: 24,
            color: cubit.currentIndex == 2 ? Colors.white : Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            IconlyLight.profile,
            size: 24,
            color: cubit.currentIndex == 3 ? Colors.white : Colors.grey,
          ),
        ),
      ],
      onTap: (index) {
        cubit.changeBottom(index);
      },
    );
  }
}
