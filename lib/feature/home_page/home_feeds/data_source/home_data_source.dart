import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/core/models/appointment_model/appointment_model.dart';
import 'package:mostakbal/core/models/home_model/hajjAndUmrah_model.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_cubit.dart';
import 'package:mostakbal/feature/home_page/home_feeds/controller/home_cubit.dart';

import '../../../../core/models/home_model/bannar_model.dart';
import '../../../../core/models/home_model/for_you_tap_model.dart';
import '../../../../core/models/home_model/tourism_model.dart';

class HomeDataSource {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ///todo get HajjAndUmrah
  Future<HajjAndUmrahModel> getAppointment() async {
    final result = await fireStore.collection('HajjAndUmrah').doc().get();
    return HajjAndUmrahModel.fromJson(result.data()!);
  }

  List<BannarModel> bannerModel = [];

  ///todo get bannar
  Future<void> getBannar() async {
    fireStore.collection('bannar').get().then(
      (value) {
        for (var element in value.docs) {
          bannerModel.add(BannarModel.fromJson(element.data()));
        }
      },
    );
  }

  List<TripModel> forYouModel = [];
  List<String> forYouIdModel = [];

  ///todo get forYou data
  Future<void> getForYouData() async {
    fireStore.collection('forYou').get().then(
      (value) {
        for (var element in value.docs) {
          forYouIdModel.add(element.id);
          forYouModel.add(TripModel.fromJson(element.data()));
        }
      },
    );
  }

  List<TourismModel> domesticTourismModel = [];

  ///todo get domesticTourism
  Future<void> getDomesticTourism() async {
    fireStore.collection('domesticTourism').get().then(
      (value) {
        for (var element in value.docs) {
          domesticTourismModel.add(TourismModel.fromJson(element.data()));
        }
      },
    );
  }

  List<TourismModel> foreignTourismModel = [];

  ///todo get domesticTourism
  Future<void> getForeignTourism() async {
    fireStore.collection('foreignTourism').get().then(
      (value) {
        for (var element in value.docs) {
          foreignTourismModel.add(TourismModel.fromJson(element.data()));
        }
      },
    );
  }

  List<HajjAndUmrahModel> hajjAndUmrahModel = [];
  List<String> hajjAndUmrahModelId = [];

  ///todo get HajjAndUmrah
  Future<void> getHajjAndUmrah() async {
    fireStore.collection('HajjAndUmrah').get().then(
      (value) {
        for (var element in value.docs) {
          hajjAndUmrahModelId.add(element.id);
          hajjAndUmrahModel.add(HajjAndUmrahModel.fromJson(element.data()));
        }
      },
    );
  }


  List<TourismModel> offerModel = [];
  List<String> offerModelId =[];
  ///todo get getOffer
  Future<void> getOffer() async {
    fireStore.collection('offers').get().then(
          (value) {
        for (var element in value.docs) {
          offerModelId.add(element.id);
          offerModel.add(TourismModel.fromJson(element.data()));
          print(offerModel);
        }
      },
    );
  }
}
