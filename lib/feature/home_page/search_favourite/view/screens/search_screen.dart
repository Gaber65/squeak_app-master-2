import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/home_page/search_favourite/controller/search_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/const/components/elevated_button.dart';
import '../../../home_feeds/view/component/feeds_component/feeds_component.dart';
import '../component/grid_view_search.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isClick = false;

  bool showSheet = false;

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(cubit),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'نتائج البحث',
                        style: FontStyle().textStyle(fontSize: 14),
                      ),
                      Text(
                        '(${cubit.searchModel.length})',
                        style: FontStyle().textStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isClick = !isClick;
                          });
                        },
                        icon: Icon(
                          Icons.horizontal_split_sharp,
                          color:
                              isClick ? ColorStyle().primaryColor : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isClick = !isClick;
                          });
                        },
                        icon: Icon(
                          Icons.grid_view_rounded,
                          color: !isClick
                              ? ColorStyle().primaryColor
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is GetSearchLoading) const LinearProgressIndicator(),
                if (cubit.searchModel.isEmpty) const Spacer(),
                if (cubit.searchModel.isEmpty)
                  Column(
                    children: [
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fphoto_6012370885283003964_x.jpg?alt=media&token=c8463b83-80c8-4333-a805-56627cd6902a',
                        height: 142,
                        width: 142,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'لا يوجد نتائج ',
                        style: FontStyle().textStyle(),
                      ),
                    ],
                  ),
                if (cubit.searchModel.isEmpty) const Spacer(),
                if (state is GetSearchSuccess && !isClick)
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 280.0,
                        maxCrossAxisExtent: 300.0,
                      ),
                      itemBuilder: (context, index) {
                        return getSearchGridView(
                            context, cubit.searchModel[index], index);
                      },
                      itemCount: cubit.searchModel.length,
                    ),
                  ),
                if (state is GetSearchSuccess && isClick)
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return buildPaddingOtherOffers(
                            context, cubit.searchModel[index]);
                      },
                      itemCount: cubit.searchModel.length,
                    ),
                  ),
              ],
            ),
            bottomSheet: !showSheet
                ? null
                : DefaultTabController(
                    length: 4,
                    child: Material(
                      elevation: 12,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'فلترة نتائج البحث',
                                  style: FontStyle().textStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'اعادة تعيين',
                                    style: FontStyle().textStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontColor: ColorStyle().primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'ترتيب النتائج حسب',
                              style: FontStyle().textStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            buildTabBarItemSearch(),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'السعر',
                              style: FontStyle().textStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SfRangeSelector(
                              min: 1000.0,
                              max: 9000.0,

                              initialValues: const SfRangeValues(2000, 5000),
                              interval: 1,
                              child: Container(
                                height: 100,
                                child: SfCartesianChart(
                                  backgroundColor: Colors.transparent,
                                  plotAreaBackgroundColor: Colors.transparent,
                                  series: <ChartSeries<ChartData, int>>[
                                    ColumnSeries<ChartData, int>(
                                        dataSource: chartData,

                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        // Width of the columns
                                        width: 0.2,
                                        // Spacing between the columns
                                        spacing: 0.1
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'السعر',
                              style: FontStyle().textStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DefaultTabController(
                              length: 5,
                              child: buildTabBarItemSearch2(),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'الخدمات المتاحة',
                              style: FontStyle().textStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Image.network('https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/photo_6012370885283004039_x.jpg?alt=media&token=10e261ec-dcad-4561-99f3-a5c05dda89b2'),
                            const SizedBox(
                              height: 15,
                            ),
                            MyElevatedButton(
                              onPressed: () {
                                cubit.searchModel.clear();
                                cubit.fireSearch(
                                    flightName: searchController.text);
                              },
                              text: 'عرض (${cubit.searchModel.length} نتيجة)',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(SearchCubit cubit) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'البحث',
        style: FontStyle().textStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                showSheet = !showSheet;
              });
            },
            icon: Icon(
              IconlyLight.filter,
              color: showSheet ? ColorStyle().primaryColor : Colors.black,
            )
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.white,
            elevation: 3,
            shadowColor: const Color.fromRGBO(180, 188, 201, 0.12),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: () {
                      cubit.searchModel.clear();

                      cubit.fireSearch(flightName: searchController.text);
                    },
                    child: Image.network(
                      width: 24,
                      height: 24,
                      'https://firebasestorage.googleapis.com/v0/b/mostakbal-acd29.appspot.com/o/onboarding%2Fimage%20(13).png?alt=media&token=8b6194be-8cbc-4723-a741-cc807a1bff15',
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      cursorColor: ColorStyle().secondColor,
                      onChanged: (value) {
                        cubit.searchModel.clear();

                        cubit.fireSearch(flightName: value);
                      },
                      decoration: InputDecoration(
                        hintText: 'قم بالبحث بإسم المكان او البلد',
                        hintStyle: FontStyle().textStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontColor: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
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
      ),
    );
  }
}
