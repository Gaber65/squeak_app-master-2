import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../../../../../../../../core/const/const.dart';
import '../../../../../../../../core/local/cache_helper.dart';
import '../../../../../../../authentication/view/screens/first-rigster-screen.dart';
import '../../cubit/onboarding_cubit.dart';
import '../../model/onboarding_model.dart';

Padding onboardBuildPage(OnboardingCubit cubit, OnboardingModel model,
    int index, context, PageController pageController) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: model.titleImage,
            height: 43.83,
            width: 209,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          model.describtion,
          textAlign: TextAlign.center,
          maxLines: 3,
          style: GoogleFonts.tajawal(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CachedNetworkImage(
                  imageUrl: model.imagePath,
                  height: MediaQuery.sizeOf(context).height / 1.6,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 90,
                  height: 3,
                  child: LinearProgressIndicator(
                    value: cubit.value,
                    backgroundColor: Colors.white,
                    color: Color.fromRGBO(255, 112, 41, 1),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    if (cubit.isLastPage) {
                      CacheHelper.saveData(key: 'isOnboarding', value: true).then(
                            (value) {
                          RoutePage().navigateAndRemove(
                            context,
                            const FirstRegisterScreen(),
                          );
                        },
                      );                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                    cubit.listenPageLastIndex(index == 2 ? true : false);
                    cubit.value = cubit.value + 1 / 3;
                    cubit.isClick != cubit.isClick;
                  },
                  shape: const CircleBorder(),
                  child: const Icon(
                    IconlyLight.arrow_right,
                    color: Color.fromRGBO(13, 110, 253, 1),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
