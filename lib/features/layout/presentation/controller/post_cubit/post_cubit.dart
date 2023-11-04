import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squeak/core/resources/constants_manager.dart';
import 'package:squeak/core/usecase/base_usecase.dart';
import 'package:squeak/features/layout/domain/base_repository/base_clinic_repo.dart';

import '../../../domain/entites/post/create_post_entites.dart';
import '../../../domain/entites/post/get_doctor_post_entitites.dart';
import '../../../domain/use_case/post_use_case/add_clinic_post_use_case.dart';
import '../../../domain/use_case/post_use_case/delete_clinic_post_use_case.dart';
import '../../../domain/use_case/post_use_case/get_clinic_post_use_case.dart';
import '../../../domain/use_case/post_use_case/get_doctor_posts_use_case.dart';
import '../../../domain/use_case/post_use_case/update_clinic_post_use_case.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(
    this.getPostClinicUseCase,
    this.updatePostClinicUseCase,
    this.deletePostClinicUseCase,
    this.createPostClinicUseCase,
    this.getDoctorPostClinicUseCase,
  ) : super(PostInitial());
  static PostCubit get(context) => BlocProvider.of(context);

  void removePostImage() async {
    postImage = null;
    postVideo = null;
    postCamera = null;
    emit(SqueakRemovePostImageState());
  }

  File? postImage;
  File? postVideo;
  File? postCamera;
  var picker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState(postImage!));
    } else {
      debugPrint('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  Future<void> getPostVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      emit(PostImagePickedSuccessState(postVideo!));
    } else {
      debugPrint('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  Future<void> getPostCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      postCamera = File(pickedFile.path);
      emit(PostImagePickedSuccessState(postCamera!));
    } else {
      debugPrint('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  CreatePostClinicUseCase createPostClinicUseCase;

  Future<void> createPost({
    required String title,
    required String content,
    required String image,
    required String video,
    required String clinicId,
    required String specieId,
    required String postId,
  }) async {
    emit(CreatePostLoadingState());
    final result = await createPostClinicUseCase(
      AddPostParameters(
        specieId: specieId,
        clinicId: clinicId,
        video: video,
        content: content,
        title: title,
        image: image,
        postId: postId,
      ),
    );
    result.fold(
      (l) => emit(CreatePostErrorState()),
      (r) => emit(CreatePostSuccessState(r)),
    );
  }

  UpdatePostClinicUseCase updatePostClinicUseCase;

  Future<void> updatePost({
    required String title,
    required String content,
    required String image,
    required String video,
    required String clinicId,
    required String specieId,
    required String postId,
  }) async {
    emit(UpdatePostLoadingState());
    final result = await updatePostClinicUseCase(
      AddPostParameters(
        specieId: specieId,
        clinicId: clinicId,
        video: video,
        content: content,
        title: title,
        image: image,
        postId: postId,
      ),
    );
    result.fold(
      (l) => emit(UpdatePostErrorState()),
      (r) => emit(UpdatePostSuccessState()),
    );
  }

  DeletePostClinicUseCase deletePostClinicUseCase;

  Future<void> deletePost({
    required String postId,
  }) async {
    emit(DeletePostLoadingState());
    final result = await deletePostClinicUseCase(
      AddPostParameters(
        specieId: '',
        clinicId: '',
        video: '',
        content: '',
        title: '',
        image: '',
        postId: postId,
      ),
    );
    result.fold(
      (l) => emit(DeletePostErrorState()),
      (r) => emit(DeletePostSuccessState()),
    );
  }

  // PostDoctorEntities? postEntities;
  // Future<void> getPost() async {
  //   emit(GetPostLoadingState());
  //   final result = await getPostClinicUseCase(NoParameters());
  //   result.fold(
  //       (l) => emit(GetPostErrorState()),
  //       (r) => {
  //             postEntities = r,
  //             emit(GetPostSuccessState(r)),
  //           });
  // }

  GetDoctorPostClinicUseCase getDoctorPostClinicUseCase;
  PostDoctorEntities? postDoctorEntities;
  // Future<void> getDoctorPost() async {
  //   emit(GetDoctorPostLoadingState());
  //   final result = await getDoctorPostClinicUseCase(
  //       GetPostParameters(pageNumber: allPostPageNumber));
  //   result.fold(
  //     (l) => emit(GetDoctorPostErrorState()),
  //     (r) => {
  //       postDoctorEntities = r,
  //       print(
  //           '*********************//////******** ${r} ***************//////*************'),
  //       emit(GetDoctorPostSuccessState(r)),
  //     },
  //   );
  // }

  List<Posts> doctorPosts = [];
  int allPostPageNumber = 1;
  List<Posts> doctorPostsModel = [];
  Future getAllDoctorPost({
    bool pagination = false,
  }) async {
    if (pagination) {
      emit(PaginationLoadingState());
    } else {
      emit(GetDoctorPostLoadingState());
    }
    final result = await getDoctorPostClinicUseCase(
      GetPostParameters(
        pageNumber: allPostPageNumber,
      ),
    );
    print(result);
    result.fold((l) {
      print(l.message);
      emit(GetDoctorPostErrorState());
    }, (r) {
      print(allPostPageNumber);
      print(doctorPosts.length);
      print(doctorPostsModel.length);
      doctorPostsModel = r.data!.getPost;
      if (doctorPostsModel.isNotEmpty) {
        allPostPageNumber++;
        doctorPosts.addAll(doctorPostsModel);

        emit(GetDoctorPostSuccessState(r));
      } else {
        emit(PaginationErrorState());
      }
    });
  }

  List<Posts> userPosts = [];
  int allPostUserPageNumber = 1;
  List<Posts> userPostsModel = [];
  PostDoctorData? condationPost;
  GetPostClinicUseCase getPostClinicUseCase;

  Future getAllUserPost({
    bool pagination = false,
  }) async {
    if (pagination) {
      emit(PaginationLoadingState());
    } else {
      emit(GetPostLoadingState());
    }

    final result = await getPostClinicUseCase(
      GetPostParameters(
        pageNumber: allPostUserPageNumber,
      ),
    );

    result.fold((l) {
      print(l.message);
      emit(GetPostErrorState());
    }, (r) {
      condationPost = r.data!;
      print(userPostsModel.length);
      print(r.data!.getPost);
      print(userPostsModel);
      userPostsModel = r.data!.getPost;
      if (userPostsModel.isNotEmpty) {
        allPostUserPageNumber++;
        userPosts.clear();
        userPosts.addAll(userPostsModel);
        emit(GetPostSuccessState(r));
      } else {
        emit(PaginationErrorState());
      }
    });
  }

  bool handleRefreshBool = false;
  void handleRefresh() async {
    handleRefreshBool = true;
   await Future.delayed(
      const Duration(seconds: 1),
      () {
        handleRefreshBool = false;
      },
    );
    print(handleRefreshBool);
    emit(GetRefreshIndicatorState());
  }
}
