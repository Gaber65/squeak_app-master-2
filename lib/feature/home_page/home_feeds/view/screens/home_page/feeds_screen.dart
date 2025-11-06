import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/core/models/home_model/bannar_model.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_cubit.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_state.dart';
import 'package:mostakbal/feature/home_page/home_feeds/view/screens/home_page/offer_screens.dart';
import 'package:mostakbal/feature/home_page/home_feeds/view/screens/home_page/watched_screen.dart';
import 'package:mostakbal/feature/profile-feature/controller/setting_state.dart';

import '../../../../../../core/models/auth_model/login_model.dart';
import '../../../../../profile-feature/controller/setting_cubit.dart';
import '../../../../search_favourite/view/screens/search_screen.dart';
import '../../component/feeds_component/feeds_component.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildPreferredSizeAppBar(context),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: buildTabBarItem(),
                  ),
                  SizedBox(
                    height: 384,
                    child: buildTabBarView(cubit, context),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'عروض أخرى',
                          style: FontStyle().textStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            RoutePage().navigateTo(context, OfferScreen(offerModel: cubit.offerModel,));
                          },
                          child: Row(
                            children: [
                              Text(
                                'عرض الكل',
                                style: FontStyle().textStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontColor: ColorStyle().primaryColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 12,
                                  bottom: 3,
                                ),
                                child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(15).png?alt=media&token=18dd5777-ff28-49f2-8abd-866255921ac2',
                                  width: 14,
                                  height: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  if (cubit.offerModel.isNotEmpty)
                    buildPaddingOtherOffers(context, cubit.offerModel[0]),
                  const SizedBox(
                    height: 14,
                  ),
                  if (cubit.bannerModel.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildBanner(context, cubit),
                    ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'تمت مشاهدتها',
                          style: FontStyle().textStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            RoutePage().navigateTo(context, WatchedScreen(offerModel: cubit.offerModel,));
                          },
                          child: Row(
                            children: [
                              Text(
                                'عرض الكل',
                                style: FontStyle().textStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontColor: ColorStyle().primaryColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 12,
                                  bottom: 3,
                                ),
                                child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(15).png?alt=media&token=18dd5777-ff28-49f2-8abd-866255921ac2',
                                  width: 14,
                                  height: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 490,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 280.0,
                        maxCrossAxisExtent: 300.0,
                      ),
                      itemBuilder: (context, index) {
                        return buildPaddingWatch(
                            context, cubit.offerModel[index], index);
                      },
                      itemCount: cubit.offerModel.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TabBar buildTabBarItem() {
    return TabBar(
      labelColor: ColorStyle().primaryColor,
      unselectedLabelColor: Colors.grey,
      labelStyle: FontStyle().textStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontColor: ColorStyle().primaryColor,
      ),
      unselectedLabelStyle: FontStyle().textStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontColor: Colors.grey,
      ),
      indicatorColor: ColorStyle().primaryColor,
      isScrollable: true,
      tabs: const [
        Text(
          'مقترحة لك',
        ),
        Text(
          'سياحة داخلية',
        ),
        Text(
          'سياحة خارجية',
        ),
        Text(
          'الحج و العمرة',
        ),
      ],
    );
  }

  PreferredSize buildPreferredSizeAppBar(
    BuildContext context,
  ) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(200),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SettingCubit.get(context);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(12).png?alt=media&token=91d9ff0a-b8fb-4fde-a18f-8624e8a69110',
                fit: BoxFit.contain,
                alignment: Alignment.topRight,
                width: MediaQuery.sizeOf(context).width,
                height: 222,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(42),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 3,
                              bottom: 2,
                              right: 3,
                              left: 20,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                  cubit.settingDataSource!.userDataModel!.image,
                                )),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'مرحبا , ${cubit.settingDataSource!.userDataModel!.fullName}',
                                  style: FontStyle().textStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          backgroundColor: Color.fromRGBO(245, 244, 248, 1),
                          child: Icon(IconlyLight.notification),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'نحن هنا لخدمتك.',
                      style: FontStyle()
                          .textStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),

                      onTap: () {
                        RoutePage().navigateTo(
                          context,
                           SearchScreen(),
                        );
                      },
                      child: Material(
                        color: Colors.white,
                        shadowColor: const Color.fromRGBO(180, 188, 201, 0.12),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 12,
                              ),
                              Image.network(
                                width: 24,
                                height: 24,
                                'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(13).png?alt=media&token=8b6194be-8cbc-4723-a741-cc807a1bff15',
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'قم بالبحث بإسم المكان او البلد',
                                style: FontStyle().textStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontColor: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 32,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(12)),
                                width: 2,
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              const Icon(
                                IconlyLight.voice_2,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
