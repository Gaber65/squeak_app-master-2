part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class SendMessageLoadingState extends ChatState {}

class SendMessageSuccessState extends ChatState {
  CreateMessageEntities createMessageEntities;

  SendMessageSuccessState(this.createMessageEntities);
}

class SendMessageErrorState extends ChatState {
  final String error;

  SendMessageErrorState(this.error);
}

class GetMessageUserSuccessState extends ChatState {
  GetMassageEntities e;
  GetMessageUserSuccessState(this.e);

}class GetMessageAdminSuccessState extends ChatState {
  GetMassageEntities e;
  GetMessageAdminSuccessState(this.e);
}

class GetMessageErrorState extends ChatState {
  final String error;
  GetMessageErrorState(this.error);
}

class GetMessageLoadingState extends ChatState {}



class MessagePickedSoundSuccessState extends ChatState {
  final File file;

  MessagePickedSoundSuccessState(this.file);
}



class MessagePickedSoundErrorState extends ChatState {}

class MessagePickedImageSuccessState extends ChatState {
  final File file;

  MessagePickedImageSuccessState(this.file);
}

class MessagePickedImageErrorState extends ChatState {}

class UploadMessageImageErrorState extends ChatState {}

class DeleteFileSuccess extends ChatState {}


class SendNotificationMessageSuccessState extends ChatState {}

class SendNotificationMessageErrorState extends ChatState {
  final String error;

  SendNotificationMessageErrorState(this.error);
}


class StartSuccess extends ChatState {}
class PaginationLoadingState extends ChatState {}
class PaginationErrorState extends ChatState {}


