import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mostakbal/core/models/home_model/tourism_model.dart';
import 'package:mostakbal/main.dart';

class FavDataSource {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ///todo add fave
  Future<void> addToFav({
    required Map<String, dynamic> model,
    required String id,
  }) async {
    fireStore
        .collection('users')
        .doc(uId)
        .collection('favUser')
        .doc(id)
        .set(model);
  }

  ///todo remove fave
  Future<void> removeToFav({required String modelId}) async {
    fireStore
        .collection('users')
        .doc(uId)
        .collection('favUser')
        .doc(modelId)
        .delete();
  }

  List<TourismModel> model = [];
  List<String> favId = [];

  ///todo get fave
  Future<void> getToFav() async {
    fireStore
        .collection('users')
        .doc(uId)
        .collection('favUser')
        .snapshots()
        .listen((value) {
      model.clear();
      for (var e in value.docs) {
        model!.add(TourismModel.fromJson(e.data()));
        print(e.data());
        favId.add(e.id);
      }
    });
  }
}
