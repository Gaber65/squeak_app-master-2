import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/models/home_model/bannar_model.dart';
import 'package:mostakbal/feature/fav-feature/view/screens/fav-screen.dart';
import 'package:mostakbal/feature/home_page/home_feeds/view/screens/home_page/feeds_screen.dart';
import 'package:mostakbal/feature/profile-feature/view/screens/profile-screen.dart';

import '../../../../core/models/home_model/for_you_tap_model.dart';
import '../../../../core/models/home_model/hajjAndUmrah_model.dart';
import '../../../../core/models/home_model/hotail_model.dart';
import '../../../../core/models/home_model/tourism_model.dart';
import '../../../appointment/view/screens/Booking1-screen.dart';
import '../data_source/details_home_data_source.dart';
import '../data_source/home_data_source.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  HomeDataSource homeDataSource = HomeDataSource();
  DetailsHomeDataSource detailsHomeDataSource = DetailsHomeDataSource();
  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    BookingScreen1(),
    FavScreen(),
    ProfileScreen()
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<BannarModel> bannerModel = [];

  ///todo get bannar
  void getBannar() async {
    emit(LoadingGetBannerState());
    try {
      homeDataSource.getBannar();
      bannerModel = homeDataSource.bannerModel!;
      emit(SuccessGetBannerState());
    } catch (e, s) {
      print(s);
      emit(ErrorGetBannerState());
    }
  }

  List<TripModel> forYouModel = [];
  List<String> forYouIdModel = [];

  ///todo get for you data
  void getForYouData() async {
    emit(LoadingGetForYouDataState());
    try {
      homeDataSource.getForYouData();
      forYouModel = homeDataSource.forYouModel!;
      forYouIdModel = homeDataSource.forYouIdModel;
      emit(SuccessGetForYouDataState());
    } catch (e, s) {
      print(s);
      emit(ErrorGetForYouDataState());
    }
  }

  List<TourismModel> domesticTourismModel = [];

  ///todo get for you data
  void getDomesticTourism() async {
    emit(LoadingGetDomesticTourismState());
    try {
      homeDataSource.getDomesticTourism();
      domesticTourismModel = homeDataSource.domesticTourismModel!;
      emit(SuccessGetDomesticTourismState());
    } catch (e, s) {
      print(s);
      emit(ErrorGetDomesticTourismSState());
    }
  }

  List<TourismModel> foreignTourismModel = [];

  ///todo get for you data
  void getForeignTourism() async {
    emit(LoadingGetDomesticTourismState());
    try {
      homeDataSource.getForeignTourism();
      foreignTourismModel = homeDataSource.foreignTourismModel!;
      emit(SuccessGetDomesticTourismState());
    } catch (e, s) {
      print(s);
      emit(ErrorGetDomesticTourismSState());
    }
  }

  List<TourismModel> offerModel = [];

  ///todo get for you data
  void getOffer() async {
    emit(LoadingGetDomesticTourismState());
    try {
      homeDataSource.getOffer().then((value) {
        offerModel = homeDataSource.offerModel;
        emit(SuccessGetDomesticTourismState());
      });

    } catch (e, s) {
      print(s);
      emit(ErrorGetDomesticTourismSState());
    }
  }

  List<HajjAndUmrahModel> hajjAndUmrahModel = [];

  ///todo get HajjAndUmrah
  Future<void> getHajjAndUmrah() async {
    emit(LoadingGetDomesticTourismState());
    try {
      homeDataSource.getHajjAndUmrah();
      hajjAndUmrahModel = homeDataSource.hajjAndUmrahModel!;
      emit(SuccessGetDomesticTourismState());
    } catch (e, s) {
      print(s);
      emit(ErrorGetDomesticTourismSState());
    }
  }

  List<HotailModel> hotailModel = [];

  ///todo get Hotail
  Future<void> getHotailDetails({
    required String itemId,
  }) async {
    emit(LoadingGetHotailState());

    try {
      detailsHomeDataSource.getHotailDetails(itemId: itemId);
      hotailModel = detailsHomeDataSource.hotailModel;
      emit(SuccessGetHotailState());
    } catch (e, s) {
      print(s);
      emit(ErrorGetHotailState());
    }
  }
}
