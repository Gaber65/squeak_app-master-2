import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_cubit.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_state.dart';
import 'package:mostakbal/core/const/const.dart';

import '../../../../../../core/models/home_model/hotail_model.dart';

class HotailScreen extends StatelessWidget {
  HotailScreen({super.key, required this.itemId, required this.hotailName});

  String itemId;
  String hotailName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHotailDetails(itemId: itemId),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                hotailName,
                style: FontStyle()
                    .textStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 280.0,
                      maxCrossAxisExtent: 300.0,
                    ),
                    itemBuilder: (context, index) {
                      return buildAccompanying(
                        cubit.hotailModel.first.accompanying.values
                            .elementAt(index),
                        index,
                      );
                    },
                    itemCount: cubit.hotailModel.first.accompanying.length,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildAccompanying(HotailModel model, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          model.accompanying.keys.elementAt(
            index,
          ),
        ),
        Image(
          image: CachedNetworkImageProvider(
            model.accompanying.values.elementAt(
              index,
            ),
          ),
        ),
      ],
    );
  }
}
