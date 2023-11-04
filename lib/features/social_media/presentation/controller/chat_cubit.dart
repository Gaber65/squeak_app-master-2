import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/features/social_media/domain/entities/get_massage_entities.dart';
import '../../../../core/service/service_locator.dart';
import '../../domain/base_repository/chat_base_repo.dart';
import '../../domain/entities/create_message_entities.dart';
import '../../domain/use_case/create_admin_massage_use_case.dart';
import '../../domain/use_case/get_receiver_massage_use_case.dart';
import '../../domain/use_case/get_sender_massage_use_case.dart';
import '../../domain/use_case/send_message_use_case.dart';
import '../../domain/use_case/send_notification_use_case.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(
    this.sendNotificationUseCase,
    this.sendMessageUseCase,
    this.getAdminMassageUseCase,
    this.getUserMassageUseCase,
    this.sendMessageAdminUseCase,
  ) : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  SendNotificationUseCase sendNotificationUseCase;

  SendMessageUseCase sendMessageUseCase;

  Future<void> sendMessage({
    required String description,
    required String clinicId,
    String? image,
    String? video,
    String? audio,
  }) async {
    emit(SendMessageLoadingState());
    final result = await sendMessageUseCase(
      CreateMassageParameter(
        description: description,
        image: image ?? '',
        video: video ?? '',
        audio: audio ?? '',
        clinicId: clinicId,
      ),
    );

    result.fold(
      (l) {
        emit(SendMessageErrorState(l.message.toString()));
      },
      (r) {
        emit(SendMessageSuccessState(r));
        print(r.createMessageData);
      },
    );
  }

  SendMessageAdminUseCase sendMessageAdminUseCase;
  Future<void> sendAdminMessage({
    required String toUserId,
    required String description,
    required String clinicId,
    String? image,
    String? video,
    String? audio,
  }) async {
    emit(SendMessageLoadingState());
    final result = await sendMessageAdminUseCase(
      CreateMassageParameter(
        description: description,
        image: image ?? '',
        video: video ?? '',
        audio: audio ?? '',
        toUserId: toUserId,
        clinicId: clinicId,
      ),
    );

    result.fold(
      (l) {
        emit(SendMessageErrorState(l.message.toString()));
      },
      (r) {
        emit(SendMessageSuccessState(r));
        print(r.createMessageData);
      },
    );
  }

  // GetMassageEntities? receiverUserData;
  // Future<void> getUserMassage({
  //   required String clinicId,
  // }) async {
  //   emit(GetMessageLoadingState());
  //
  //   final result = await getUserMassageUseCase(
  //     GetMassageParameter(
  //       userId: '',
  //       clinicId: clinicId,
  //     ),
  //   );
  //   result.fold(
  //     (l) {
  //       emit(GetMessageErrorState(l.message));
  //     },
  //     (r) {
  //       print('UserMassage');
  //
  //       print(r);
  //       receiverUserData = r;
  //       emit(GetMessageSuccessState(r));
  //     },
  //   );
  // }

  // GetMassageEntities? receiverAdminData;
  //
  // Future<void> getAdminMassage({
  //   required String userId,
  //   required String clinicId,
  // }) async {
  //   emit(GetMessageLoadingState());
  //
  //   final result = await getUserMassageUseCase(
  //     GetMassageParameter(
  //       userId: userId,
  //       clinicId: clinicId,
  //     ),
  //   );
  //   result.fold(
  //     (l) {
  //       emit(GetMessageErrorState(l.message));
  //     },
  //     (r) {
  //       print('AdminMassage');
  //       print(r);
  //       receiverAdminData = r;
  //       emit(GetMessageSuccessState(r));
  //     },
  //   );
  // }

  GetUserMassageUseCase getUserMassageUseCase;
  List<CreateMessageData> userMassages = [];
  List<CreateMessageData> userMassagesModel = [];
  int allUserPageNumber = 1;
  Future getAllUserMassage({
    bool pagination = false,
    required String clinicId,
  }) async {
    if (pagination) {
      emit(PaginationLoadingState());
    } else {
      emit(GetMessageLoadingState());
    }
    final result = await getUserMassageUseCase(
      GetMassageParameter(
        pageNumber: allUserPageNumber,
        clinicId: clinicId,
        userId: '',
      ),
    );
    print(result);
    result.fold((l) {
      print(l.message);
      emit(GetMessageErrorState(l.message));
    }, (r) {
      userMassagesModel = r.massages!;
      if (userMassagesModel.isNotEmpty) {
        userMassages.clear();
        allUserPageNumber++;
        userMassages.addAll(userMassagesModel);
        emit(GetMessageUserSuccessState(r));
      } else {
        emit(PaginationErrorState());
      }
    });
  }

  GetUserMassageUseCase getAdminMassageUseCase;
  List<CreateMessageData> adminMassages = [];
  List<CreateMessageData> adminMassagesModel = [];
  int allAdminPageNumber = 1;
  Future getAllAdminMassage({
    bool pagination = false,
    required String userId,
    required String clinicId,
  }) async {
    if (pagination) {
      emit(PaginationLoadingState());
    } else {
      emit(GetMessageLoadingState());
    }
    final result = await getUserMassageUseCase(
      GetMassageParameter(
        pageNumber: allAdminPageNumber,
        clinicId: clinicId,
        userId: userId,
      ),
    );
    print(result);
    result.fold(
      (l) {
        print(l.message);
        emit(GetMessageErrorState(l.message));
      },
      (r) {
        adminMassagesModel = r.massages!;
        print(r.massages);
        print(adminMassagesModel.length);
        if (adminMassagesModel.isNotEmpty) {
          allUserPageNumber++;
          print(adminMassages.length);
          adminMassages.clear();
          adminMassages.addAll(adminMassagesModel);
          emit(GetMessageAdminSuccessState(r));
        } else {
          emit(PaginationErrorState());
        }
      },
    );
  }

  File? messageImageFromCamera;

  Future<void> getMessageImageFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      messageImageFromCamera = File(pickedFile.path);
      emit(MessagePickedImageSuccessState(messageImageFromCamera!));
    } else {
      emit(MessagePickedImageErrorState());
    }
  }

  File? messageImage;

  Future<void> getMessageImageFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      emit(MessagePickedImageSuccessState(messageImage!));
    } else {
      emit(MessagePickedImageErrorState());
    }
  }

  Future<void> deleteFile() async {
    messageImage = null;
    messageImageFromCamera = null;
    emit(DeleteFileSuccess());
  }

  Future<void> getSound({
    required File file,
  }) async {
    emit(MessagePickedSoundSuccessState(file));
  }

  bool isStart = false;
  Future<void> changeTheme() async {
    isStart = !isStart;
    emit(StartSuccess());
  }
}
