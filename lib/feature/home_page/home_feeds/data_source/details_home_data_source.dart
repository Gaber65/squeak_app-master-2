import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/models/home_model/hotail_model.dart';

class DetailsHomeDataSource {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<HotailModel> hotailModel = [];

  ///todo get Hotail
  Future<void> getHotailDetails({
    required String itemId,
  }) async {
    fireStore.collection('forYou').doc(itemId).collection('hotail').get().then(
          (value) {
        for (var element in value.docs) {
          hotailModel.add(HotailModel.fromJson(element.data()));
        }
      },
    );
  }
}
