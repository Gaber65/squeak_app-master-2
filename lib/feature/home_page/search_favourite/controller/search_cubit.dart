import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/home_model/tourism_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<TourismModel> searchModel = [];

  Future<void> fireSearch({
    required String flightName,
  }) async {
    emit(GetSearchLoading());
    try {
      fireStore
          .collection('offers')
          .where('flightName', isGreaterThanOrEqualTo: flightName)
          .snapshots()
          .listen(
            (event) {
          for (var ele in event.docs) {
            searchModel.add(TourismModel.fromJson(ele.data()));
            print(ele.data());
            emit(GetSearchSuccess());
          }
        },
      );
    } catch (e, s) {
      emit(GetSearchError());
      print(s);
    }
  }
}
