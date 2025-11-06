import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../../core/models/auth_model/login_model.dart';
import '../models/chat_model.dart';
import 'chat-states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(InitialChatPageStates());

  static ChatCubit get(context) => BlocProvider.of(context);
  File? chatImage;
  UserDataModel? userModel;
  var picker = ImagePicker();



//All User
  List<UserDataModel> allUser = [];
  UserDataModel? allAdmin;
  void getAllUserData() {
    emit(GetAllUserLoadingHomePageStates());
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != FirebaseAuth.instance.currentUser?.uid) {
          allUser.add(UserDataModel.fromJson(element.data()));
        }
      }
      emit(GetAllUserSuccessHomePageStates());
    }).onError((onError) {
      print(onError.toString());
      emit(GetAllUserErrorHomePageStates());
    });
  }

  void getAdminData() {
    emit(GetAllUserLoadingHomePageStates());
    FirebaseFirestore.instance
        .collection('users')
        .doc('H4tYPw18nrNaahQtvljf6v86oc53')
        .snapshots()
        .listen((value) {
      allAdmin = UserDataModel.fromJson(value.data()!);
      emit(GetAllUserSuccessHomePageStates());
    }).onError((onError) {
      print(onError.toString());
      emit(GetAllUserErrorHomePageStates());
    });
  }

  Future<void> getChatImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<void> sendChatImage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
  }) async {
    emit(UpdateUserLoadingHomePageStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
          receiverId: receiverId,
          dateTime: dateTime,
          text: text,
          image: value,
        );
        emit(UpdateUserSuccessHomePageStates());
      }).catchError((onError) {
        print(onError.toString());
        emit(UpdateUserErrorHomePageStates());
      });
    });
  }

  List<MessageModel> adminList = [];
  List<MessageModel> messages = [];

  void getMessage({required String receiveId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(receiveId)
        .collection('message')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .listen((event) {
        messages.clear();
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }

      print(messages.length);
      emit(Sucessgetmessage());
    });
  }

  void removePostImage() {
    chatImage = null;

    emit(SocialRemovePostImageState());
  }

  var uId = FirebaseAuth.instance.currentUser?.uid;

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
  }) {
    MessageModel massageModel = MessageModel(
      message: text,
      senderId: uId,
      receiverId: receiverId,
      time: dateTime,
      image: image ?? '',
    );

    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });


    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(uId)
        .collection('message')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  void getMessageAdmin({required String receiveId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(receiveId)
        .collection('message')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      adminList.clear();
      for (var element in event.docs) {
        adminList.add(MessageModel.fromJson(element.data()));
      }
      print(messages.length);
      emit(Sucessgetmessage());
    });
  }
}
