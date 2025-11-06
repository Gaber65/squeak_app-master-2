import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostakbal/core/models/home_model/tourism_model.dart';
import 'package:mostakbal/feature/fav-feature/controller/fav_cubit.dart';
import 'package:mostakbal/feature/home_page/search_favourite/view/screens/search_screen.dart';
import '../../../../core/const/const.dart';
import 'package:iconly/iconly.dart';

class FavScreen extends StatefulWidget {
  FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  bool isClick = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavCubit, FavState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = FavCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'المفضلة',
              style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
            bottom: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isClick = !isClick;
                      });
                    },
                    icon: Icon(
                      Icons.horizontal_split_sharp,
                      color: isClick ? ColorStyle().primaryColor : Colors.grey,

                    ),),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isClick = !isClick;
                    });
                  },
                  icon: Icon(
                    Icons.grid_view_rounded,
                    color: !isClick ? ColorStyle().primaryColor : Colors.grey,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  RoutePage().navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  IconlyLight.search,
                  color: ColorStyle().primaryColor,
                ),
              ),
            ],
          ),
          body: isClick
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return buildPaddingOtherOffers(
                        context, cubit.favDataSource.model![index], index);
                  },
                  itemCount: cubit.favDataSource.model!.length,
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280.0,
                    maxCrossAxisExtent: 300.0,
                  ),
                  itemCount: cubit.favDataSource.model!.length,
                  itemBuilder: (context, index) {
                    return buidGrid(
                        context, cubit.favDataSource.model![index], index);
                  },
                ),
        );
      },
    );
  }

  Padding buildPaddingOtherOffers(
      BuildContext context, TourismModel cubit, int index) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        cubit!.image,
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
                            FavCubit.get(context).removeToFav(modelId: FavCubit.get(context).favDataSource.favId[index]);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cubit!.location,
                        style: FontStyle().textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                          const Icon(
                            IconlyLight.calendar,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'إنضم 24 شخصا',
                            style: FontStyle().textStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
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
                const SizedBox(
                  width: 5,
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

  Padding buidGrid(BuildContext context, TourismModel cubit, int index) {
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

            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      cubit.image,
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
                          FavCubit.get(context).removeToFav(modelId: FavCubit.get(context).favDataSource.favId[index]);

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
                    children: [
                      Text(
                        cubit.flightName,
                        style: FontStyle().textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            IconlyLight.location,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Text(
                            'الساحل الشمالي',
                            style: FontStyle().textStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.grey,
                            ),
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                        mainAxisAlignment: MainAxisAlignment.start,
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
}
