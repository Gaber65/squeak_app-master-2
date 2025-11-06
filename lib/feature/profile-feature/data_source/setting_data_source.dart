import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mostakbal/main.dart';

import '../../../core/local/cache_helper.dart';
import '../../../core/models/auth_model/login_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingDataSource {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  UserDataModel? userDataModel;

  ///todo get User date
  Future<void> getUserData() async {
    fireStore.collection('users').doc(uId).snapshots().listen(
      (event) {
        userDataModel = UserDataModel.fromJson(event.data()!);
        print('*****$userDataModel****');
      },
    );
  }

  Future<void> updateUserDataImage({
    required File profileImage,
    required String phone,
    required String name,
    required String birthdate,
  }) async {
    storage
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            updateUserData(
              name: name,
              phone: phone,
              image: value,
              birthdate: birthdate,
            );
          },
        );
      },
    );
  }

  void updateUserData({
    required String phone,
    required String name,
    required String birthdate,
    String? image,
  }) {
    fireStore
        .collection('users')
        .doc('${CacheHelper.getData(key: 'uId')}')
        .update(
      {
        "phone": phone,
        "name": name,
        "birthdate": birthdate,
        "image": image ?? userDataModel!.image,
      },
    );
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        FirebaseAuth.instance.signOut(),
        CacheHelper.removeData(key: 'uId'),
      ]);
    } catch (error) {
      throw Exception();
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> deleteAccount() async {
    try {
      await Future.wait(
        [
          fireStore.collection('users').doc(uId).delete(),
          CacheHelper.removeData(key: 'uId'),
          FirebaseAuth.instance.currentUser!.delete(),
        ],
      );
    } catch (error) {
      throw Exception();
    }
  }
}
