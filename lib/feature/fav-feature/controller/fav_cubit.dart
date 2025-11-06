import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/feature/fav-feature/data_source/fav_data_source.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  static FavCubit get(context) => BlocProvider.of(context);
  FavDataSource favDataSource = FavDataSource();

  ///todo add fave
  Future<void> addToFav({
    required Map<String, dynamic> model,
    required String id,
  }) async {
    emit(AddToFavLoading());
    try {
      favDataSource.addToFav(model: model,id: id).then((value) {
        emit(AddToFavSuccess());
      });
    } catch (e, s) {
      print(s);
      emit(AddToFavError());
    }
  }

  ///todo remove fave
  Future<void> removeToFav({
    required String modelId,
  }) async {
    emit(RemoveFavLoading());
    try {
      favDataSource.removeToFav(modelId: modelId).then((value) {
        emit(RemoveFavSuccess());
      });
    } catch (e, s) {
      print(s);
      emit(RemoveFavError());
    }
  }

  ///todo get fave
  Future<void> getToFav() async {
    emit(GetVafLoading());
    try {
      favDataSource.getToFav().then((value) {
        emit(GetVafSuccess());
      });
    } catch (e, s) {
      print(s);
      emit(GetVafError());
    }
  }
}
