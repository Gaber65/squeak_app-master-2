import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/feature/fav-feature/controller/fav_cubit.dart';
import 'package:mostakbal/feature/home_page/home_feeds/view/screens/home_page/details_home_page.dart';

import '../../../../../../core/const/const.dart';
import '../../../../../../core/models/home_model/for_you_tap_model.dart';
import '../../../../../../core/models/home_model/hajjAndUmrah_model.dart';
import '../../../../../../core/models/home_model/tourism_model.dart';
import '../../../controller/home_cubit.dart';

SizedBox buildBanner(BuildContext context, HomeCubit cubit) {
  return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 123,
      child: CarouselSlider.builder(
        itemCount: cubit.bannerModel.length,
        itemBuilder: (context, index, int) => Image.network(
          cubit.bannerModel[index].bannerImage,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
        options: CarouselOptions(
          scrollPhysics: const ScrollPhysics(),
          height: 120,
          initialPage: 0,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(seconds: 2),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ));
}

Padding buildPaddingOtherOffers(BuildContext context, TourismModel model) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 140,
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.white,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      model.image,
                      width: 103,
                      height: 127,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: const Color.fromRGBO(27, 30, 40, .2),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                        },
                        icon: Icon(
                          IconlyLight.heart,
                          color: ColorStyle().secondColor,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.flightName,
                        style: FontStyle().textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            IconlyLight.calendar,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Text(
                            '9 يناير',
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                          Text(
                            ' - ',
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                          Text(
                            '3 يناير',
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Icon(
                              IconlyBold.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Icon(
                              IconlyBold.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Icon(
                              IconlyBold.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            '4.5',
                            style: FontStyle().textStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(14).png?alt=media&token=a16d8500-affa-4958-8366-5328adb3647f',
                            width: 66,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            'إنضم 24 شخصا',
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Material(
                    color: ColorStyle().primaryColor,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'ج2000',
                        style: FontStyle().textStyle(
                          fontSize: 12,
                          fontColor: Colors.white,
                          fontWeight: FontWeight.w700,
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
  );
}

Padding buildPaddingWatch(BuildContext context, TourismModel model, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      color: Colors.white,
      shadowColor: Colors.white,
      elevation: 1,
      surfaceTintColor: Colors.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    model.image,
                    width: 161,
                    height: 127,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: const Color.fromRGBO(27, 30, 40, .2),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        FavCubit.get(context).addToFav(model: model.toMap(),id: HomeCubit.get(context).homeDataSource.offerModelId[index]);

                      },
                      icon: Icon(
                        IconlyLight.heart,
                        color: ColorStyle().secondColor,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.flightName,
                      style: FontStyle().textStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          IconlyLight.location,
                          color: Colors.grey,
                          size: 16,
                        ),
                        Text(
                          model.flightName,
                          style: FontStyle().textStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4.5',
                          style: FontStyle().textStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontColor: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Icon(
                            IconlyBold.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Icon(
                            IconlyBold.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: Icon(
                            IconlyBold.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ليلة',
                          style: FontStyle().textStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontColor: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          r'\' + '2000ج',
                          style: FontStyle().textStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontColor: ColorStyle().primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

TabBarView buildTabBarView(HomeCubit cubit, context) {
  return TabBarView(
    children: [
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildSizedBoxTabForYou(cubit.forYouModel[index], context,cubit,index);
        },
        itemCount: cubit.forYouModel.length,
      ),
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildSizedBoxForeignTourism(cubit.domesticTourismModel[index]);
        },
        itemCount: cubit.domesticTourismModel.length,
      ),
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildSizedBoxForeignTourism(cubit.foreignTourismModel[index]);
        },
        itemCount: cubit.foreignTourismModel.length,
      ),
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildSizedBoxTabHajjAndUmrahModel(
            context,  cubit.hajjAndUmrahModel[index],index);
        },
        itemCount: cubit.hajjAndUmrahModel.length,
      ),
    ],
  );
}


InkWell buildSizedBoxTabForYou(TripModel model, context,HomeCubit cubit, int index) {
  return InkWell(
    onTap: () {
      print(cubit.forYouIdModel[index]);
      RoutePage().navigateTo(
        context,
        FeedsDetails(
          model: model,
          itemId: cubit.forYouIdModel[index],
        ),
      );
    },
    child: SizedBox(
      height: 384,
      width: 268,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.white,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      model.image,
                      height: 286,
                      width: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(27, 30, 40, .2),
                      child: IconButton(
                        onPressed: () {
                          FavCubit.get(context).favDataSource.model.clear();
                          FavCubit.get(context).addToFav(model: model.toMap(),id: HomeCubit.get(context).homeDataSource.forYouIdModel[index]);

                        },
                        icon: const Icon(
                          IconlyLight.heart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.flightName,
                    style: FontStyle().textStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontColor: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Icon(
                      IconlyBold.star,
                      color: Colors.amber,
                      size: 14,
                    ),
                  ),
                  Text(
                    model.rating.toString(),
                    style: FontStyle().textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    IconlyLight.location,
                    color: Colors.grey,
                    size: 14,
                  ),
                  Text(
                    model.location,
                    style: FontStyle().textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(14).png?alt=media&token=a16d8500-affa-4958-8366-5328adb3647f',
                    width: 66,
                    height: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

SizedBox buildSizedBoxTabHajjAndUmrahModel(BuildContext context,HajjAndUmrahModel model, int index) {
  return SizedBox(
    height: 384,
    width: 268,
    child: Card(
      color: Colors.white,
      shadowColor: Colors.white,
      elevation: 1,
      surfaceTintColor: Colors.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    model.image,
                    height: 286,
                    width: 240,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(27, 30, 40, .2),
                    child: IconButton(
                      onPressed: () {

                        FavCubit.get(context).addToFav(model: model.toMap(),id: HomeCubit.get(context).homeDataSource.forYouIdModel[index]);

                      },
                      icon: const Icon(
                        IconlyLight.heart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model.name,
                  style: FontStyle().textStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontColor: Colors.black,
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Icon(
                    IconlyBold.star,
                    color: Colors.amber,
                    size: 14,
                  ),
                ),
                Text(
                  model.rating.toString(),
                  style: FontStyle().textStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontColor: Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  IconlyLight.location,
                  color: Colors.grey,
                  size: 14,
                ),
                Text(
                  model.name,
                  style: FontStyle().textStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontColor: Colors.grey,
                  ),
                ),
                const Spacer(),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(14).png?alt=media&token=a16d8500-affa-4958-8366-5328adb3647f',
                  width: 66,
                  height: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

SizedBox buildSizedBoxForeignTourism(TourismModel model) {
  return SizedBox(
    height: 384,
    width: 268,
    child: Card(
      color: Colors.white,
      shadowColor: Colors.white,
      elevation: 1,
      surfaceTintColor: Colors.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    model.image,
                    height: 286,
                    width: 240,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(27, 30, 40, .2),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconlyLight.heart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model.flightName,
                  style: FontStyle().textStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontColor: Colors.black,
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Icon(
                    IconlyBold.star,
                    color: Colors.amber,
                    size: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  IconlyLight.location,
                  color: Colors.grey,
                  size: 14,
                ),
                Text(
                  model.location,
                  style: FontStyle().textStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontColor: Colors.grey,
                  ),
                ),
                const Spacer(),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(14).png?alt=media&token=a16d8500-affa-4958-8366-5328adb3647f',
                  width: 66,
                  height: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
