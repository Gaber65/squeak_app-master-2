import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/models/home_model/tourism_model.dart';
import '../../../../fav-feature/controller/fav_cubit.dart';
import '../../../home_feeds/controller/home_cubit.dart';

Padding getSearchGridView(BuildContext context, TourismModel model, int index) {
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
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                model.image,
                width: 161,
                height: 127,
                fit: BoxFit.cover,
              ),
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
                          model.location,
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

TabBar buildTabBarItemSearch() {
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
      Padding(
        padding: EdgeInsets.all(2.0),
        child: Text(
          'الاكثر شعبية',
        ),
      ),
      Padding(
        padding: EdgeInsets.all(2.0),
        child: Text(
          'الاعلى تقييماً',
        ),
      ),
      Padding(
        padding: EdgeInsets.all(2.0),
        child: Text(
          'الاعلى سعراًً',
        ),
      ),
      Padding(
        padding: EdgeInsets.all(2.0),
        child: Text(
          'الاقل سعراًًً',
        ),
      ),
    ],
  );
}

class ChartData {
  ChartData(
    this.x,
    this.y,
  );
  final int x;
  final double y;
}

final List<ChartData> chartData = [
  ChartData(1200, 1555),
  ChartData(1300, 1600),
  ChartData(1400, 1700),
  ChartData(1500, 1800),
  ChartData(1600, 1800),
  ChartData(1700, 1800),
  ChartData(1800, 1800),

];


TabBar buildTabBarItemSearch2() {
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
      Padding(
        padding: EdgeInsets.all(2.0),
        child:Row(
          children: [
            Icon(Icons.star,color: Colors.amberAccent,),
            Text('5'),
          ],
        )
      ),
      Padding(
          padding: EdgeInsets.all(2.0),
          child:Row(
            children: [
              Icon(Icons.star,color: Colors.amberAccent,),
              Text('4'),
            ],
          )
      ),
      Padding(
          padding: EdgeInsets.all(2.0),
          child:Row(
            children: [
              Icon(Icons.star,color: Colors.amberAccent,),
              Text('3'),
            ],
          )
      ),
      Padding(
          padding: EdgeInsets.all(2.0),
          child:Row(
            children: [
              Icon(Icons.star,color: Colors.amberAccent,),
              Text('2'),
            ],
          )
      ),
      Padding(
          padding: EdgeInsets.all(2.0),
          child:Row(
            children: [
              Icon(Icons.star,color: Colors.amberAccent,),
              Text('1'),
            ],
          )
      ),
    ],
  );
}
