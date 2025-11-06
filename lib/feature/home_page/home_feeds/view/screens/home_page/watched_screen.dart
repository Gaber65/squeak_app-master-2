import 'package:flutter/material.dart';
import '../../../../../../core/models/home_model/tourism_model.dart';
import 'package:mostakbal/core/const/const.dart';

import '../../component/feeds_component/feeds_component.dart';

class WatchedScreen extends StatelessWidget {
  WatchedScreen({super.key, required this.offerModel});

  List<TourismModel> offerModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'العروض',
          style:
              FontStyle().textStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: (offerModel.isNotEmpty)
          ? GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 280.0,
                maxCrossAxisExtent: 300.0,
              ),
              itemBuilder: (context, index) {
                return buildPaddingWatch(context, offerModel[index], index);
              },
              itemCount: offerModel.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
