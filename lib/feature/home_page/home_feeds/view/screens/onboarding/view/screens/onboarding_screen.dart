import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/authentication/view/screens/first-rigster-screen.dart';
import 'package:mostakbal/feature/home_page/home_feeds/view/screens/onboarding/cubit/onboarding_cubit.dart';
import 'package:mostakbal/feature/home_page/home_feeds/view/screens/onboarding/cubit/onboarding_state.dart';
import 'package:mostakbal/feature/home_page/home_feeds/view/screens/onboarding/model/onboarding_model.dart';

import '../../../../../../../../core/local/cache_helper.dart';
import '../components/onboarding_view.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = OnboardingCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: InkWell(
                onTap: () {
                  CacheHelper.saveData(key: 'isOnboarding', value: true).then(
                    (value) {
                      RoutePage().navigateAndRemove(
                        context,
                        const FirstRegisterScreen(),
                      );
                    },
                  );
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 64,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color.fromRGBO(75, 73, 79, 0.51),
                  ),
                  child: Center(
                    child: Text(
                      'تخطي',
                      style: GoogleFonts.tajawal(
                          fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            body: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return onboardBuildPage(
                  cubit,
                  onBoardInfo[index],
                  index,
                  context,
                  pageController,
                );
              },
              itemCount: onBoardInfo.length,
              scrollDirection: axisDirectionToAxis(AxisDirection.right),
              onPageChanged: (index) {
                if (cubit.isClick) {
                  cubit.value = cubit.value + 1 / 3;
                } else {
                  cubit.value = cubit.value + 1 / 3;
                }

                if (index == onBoardInfo.length - 1) {
                  cubit.listenPageLastIndex(true);
                } else {
                  cubit.listenPageLastIndex(false);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
