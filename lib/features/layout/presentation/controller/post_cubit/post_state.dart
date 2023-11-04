part of 'post_cubit.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class SqueakRemovePostImageState extends PostState {}

class AppChangeBottomSheetState extends PostState {}

class PostImagePickedSuccessState extends PostState {
  File file;
  PostImagePickedSuccessState(this.file);
}

class PostImagePickedErrorState extends PostState {}

///todo CreatePost
class CreatePostLoadingState extends PostState {}

class CreatePostSuccessState extends PostState {
  PostEntities postEntities;

  CreatePostSuccessState(this.postEntities);
}

class CreatePostErrorState extends PostState {}

///todo GetPost
class GetPostLoadingState extends PostState {}

class GetPostSuccessState extends PostState {
  PostDoctorEntities postEntities;
  GetPostSuccessState(this.postEntities);
}

class GetPostErrorState extends PostState {}

///todo UpdatePost
class UpdatePostLoadingState extends PostState {}

class UpdatePostSuccessState extends PostState {}

class UpdatePostErrorState extends PostState {}

///todo DeletePost
class DeletePostLoadingState extends PostState {}

class DeletePostSuccessState extends PostState {}

class DeletePostErrorState extends PostState {}


///todo GetDoctorPost
class GetDoctorPostLoadingState extends PostState {}

class GetDoctorPostSuccessState extends PostState {
  PostDoctorEntities postEntities;
  GetDoctorPostSuccessState(this.postEntities);
}

class GetDoctorPostErrorState extends PostState {}

class GetRefreshIndicatorState extends PostState {}

// todo Pagination
class PaginationErrorState extends PostState {}
class PaginationLoadingState extends PostState {}


