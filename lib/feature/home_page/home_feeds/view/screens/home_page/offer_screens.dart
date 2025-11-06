import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_cubit.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_state.dart';

import '../../../../../../core/models/home_model/tourism_model.dart';
import '../../component/feeds_component/feeds_component.dart';

class OfferScreen extends StatelessWidget {
  OfferScreen({super.key, required this.offerModel});

  List<TourismModel> offerModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'تم المشاهدة',
          style:
              FontStyle().textStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: (offerModel.isNotEmpty)
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              addAutomaticKeepAlives: true,
              itemBuilder: (context, index) {
                return buildPaddingOtherOffers(context, offerModel[index]);
              },
              itemCount: offerModel.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
