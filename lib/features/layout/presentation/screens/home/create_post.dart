import 'dart:convert';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/network/helper/helper_cubit.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/features/layout/layout.dart';
import 'package:squeak/features/layout/presentation/controller/notification_cubit/notification_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/add_edit_beets_state.dart';
import '../../../../../core/network/end-points.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/toast_state.dart';
import '../../../../../core/widgets/video_detail.dart';
import '../../../../../generated/l10n.dart';
import '../../../../setting/update_profile/presentation/controlls/cubit/add_edit_beets_cubit.dart';
import '../../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../../domain/entites/clinic/all_clinics_entities.dart';
import '../../controller/post_cubit/post_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class CreatePost extends StatefulWidget {
  CreatePost({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var postTextController = TextEditingController();
  bool isRTL = false;
  var formKey = GlobalKey<FormState>();
  List<SpeciesData> speciesDataList = [];

  @override
  void dispose() {
    postTextController.dispose();
    super.dispose();
  }

  bool _isRTL(String text) {
    final rtlRegex = RegExp(r'[\u0600-\u06FF]|[\u0750-\u077F]|[\u0590-\u05FF]');
    return rtlRegex.hasMatch(text);
  }

  String? dropdownValueSpecies;
  String? dropdownValueClinic;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return sl<PostCubit>();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<ClinicCubit>()..getAllSupplierClinics();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<AddBeetsCubit>()..getAllSpecies();
          },
        ),
        BlocProvider(
          create: (context) {
            return sl<HelperCubit>();
          },
        ),
      ],
      child: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          if (state is PostImagePickedSuccessState) {
            if (PostCubit.get(context).postVideo != null) {
              HelperCubit.get(context).getGlobalVideo(
                file: state.file!,
                uploadPlace: UploadPlace().postVideos,
              );
            } else if (PostCubit.get(context).postCamera != null) {
              HelperCubit.get(context).getGlobalImage(
                file: state.file!,
                uploadPlace: UploadPlace().postImages,
              );
            } else if (PostCubit.get(context).postImage != null) {
              HelperCubit.get(context).getGlobalImage(
                file: state.file!,
                uploadPlace: UploadPlace().postImages,
              );
            }
          }
          if (state is CreatePostSuccessState) {
            if (state.postEntities.success) {
              PostCubit.get(context).getAllUserPost();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LayoutScreen(),
                ),
                (route) => false,
              );
            } else {
              showToast(
                text: state.postEntities.errors!.values.first[0],
                state: ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = PostCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            drawer: DrawerWidget(scaffoldKey: scaffoldKey),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LayoutScreen(),
                      ),
                      (route) => false);
                },
                icon: const Icon(Icons.arrow_back_ios_sharp),
              ),
              actions: [
                MaterialButton(
                  minWidth: 100,
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: CachedNetworkImageProvider(
                      'https://img.freepik.com/premium-vector/image-photo-jpg-file-mountains-sun-landscape-picture-frame-with-add-button-3d-vector-icon-cartoon-minimal-style_365941-839.jpg?w=826',
                    ),
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(90),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer<AddBeetsCubit, AddBeetsState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return (AddBeetsCubit.get(context).speciesEntities !=
                                  null)
                              ? buildDropDownSpecies(
                                  AddBeetsCubit.get(context)
                                      .speciesEntities!
                                      .data!,
                                  context,
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(8),
                                    color: !BreedsTypeCubit.get(context).isDark
                                        ? Colors.black12
                                        : Colors.white10,
                                  ),
                                );
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      BlocConsumer<ClinicCubit, ClinicState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return (ClinicCubit.get(context)
                                      .allClinicSupplierEntities !=
                                  null)
                              ? buildDropDownClinic(
                                  ClinicCubit.get(context)
                                      .allClinicSupplierEntities!
                                      .data!
                                      .clinics,
                                  context)
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(8),
                                    color: !BreedsTypeCubit.get(context).isDark
                                        ? Colors.black12
                                        : Colors.white10,
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: buildTextFormField(context),
                    ),
                    if (cubit.postImage != null || cubit.postCamera != null)
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  4.0,
                                ),
                                image: DecorationImage(
                                  image: FileImage(
                                      cubit.postImage ?? cubit.postCamera!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.close,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: () {
                                cubit.removePostImage();
                              },
                            ),
                          ],
                        ),
                      ),
                    if (cubit.postVideo != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            SizedBox(
                                height: 200,
                                child: VideoFileApp(video: cubit.postVideo!)),
                            IconButton(
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.close,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: () {
                                cubit.removePostImage();
                              },
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    ConditionalBuilder(
                      condition: state is! CreatePostLoadingState,
                      builder: (context) {
                        return MyElevatedButton(
                          onPressed: () {
                            if (postTextController.text.isEmpty) {
                              showToast(
                                text: "Add Your Text",
                                state: ToastState.error,
                              );
                              return;
                            }
                            if (dropdownValueClinic == null) {
                              showToast(
                                text: "Select Supplier",
                                state: ToastState.error,
                              );
                              return;
                            }
                            if (dropdownValueSpecies == null) {
                              showToast(
                                text: "Select Species",
                                state: ToastState.error,
                              );
                              return;
                            }
                            print(dropdownClinicId);
                            print(dropdownIdValue);

                            if (formKey.currentState!.validate()) {
                              cubit.createPost(
                                content: postTextController.text,
                                title: DateTime.now().toString(),
                                image:
                                    HelperCubit.get(context).modelImage == null
                                        ? ''
                                        : HelperCubit.get(context)
                                            .modelImage!
                                            .data!,
                                video:
                                    HelperCubit.get(context).modelVideo == null
                                        ? ''
                                        : HelperCubit.get(context)
                                            .modelVideo!
                                            .data!,
                                clinicId: dropdownClinicId!,
                                specieId: dropdownIdValue!,
                                postId: 'postId',
                              );
                            }
                          },
                          text: S.of(context).publish,
                          colors: appColorBtn,
                        );
                      },
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: (cubit.postImage != null ||
                    cubit.postVideo != null ||
                    cubit.postCamera != null)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            PostCubit.get(context).getPostImage();
                          },
                          shape: const CircleBorder(),
                          child: const Card(
                            elevation: 10,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: CachedNetworkImageProvider(
                                  'https://img.freepik.com/premium-vector/yellow-camera-with-paw-print-it_695276-3064.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=ais'),
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            PostCubit.get(context).getPostCamera();
                          },
                          shape: const CircleBorder(),
                          child: const Card(
                            elevation: 10,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: CachedNetworkImageProvider(
                                'https://img.freepik.com/premium-vector/cute-cat-with-camera-cartoon-vector-illustration_607277-199.jpg?w=826',
                              ),
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            PostCubit.get(context).getPostVideo();
                          },
                          shape: const CircleBorder(),
                          child: const Card(
                            elevation: 10,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: CachedNetworkImageProvider(
                                  'https://img.freepik.com/premium-photo/fun-dog-3d-illustration_183364-96472.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      textDirection: _isRTL(postTextController.text)
          ? TextDirection.rtl
          : TextDirection.ltr,
      controller: postTextController,
      keyboardType: TextInputType.multiline,
      onChanged: (value) {
        setState(() {
          postTextController.text == value;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return '';
        }
        return null;
      },
      maxLines: null,
      maxLength: 1000,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(1000),
      ],
      decoration: InputDecoration(
        hintText: S.of(context).enterYourText,
        border: InputBorder.none,
      ),
    );
  }

  String? dropdownIdValue;
  Widget buildDropDownSpecies(List<SpeciesData> speciesData, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8),
        color: !BreedsTypeCubit.get(context).isDark
            ? Colors.grey.shade400
            : Colors.white10,
      ),
      child: DropdownButton<SpeciesData>(
        borderRadius: BorderRadius.circular(20),
        dropdownColor: !BreedsTypeCubit.get(context).isDark
            ? Colors.white
            : Colors.grey.shade900,
        underline: const SizedBox(),
        iconSize: 18,
        iconEnabledColor: Colors.black,
        hint: Text(dropdownValueSpecies ?? S.of(context).species),
        onChanged: (newValue) {
          setState(() {
            dropdownValueSpecies = newValue!.enType;
            dropdownIdValue = newValue!.id!;
          });
        },
        items: speciesData.map((SpeciesData value) {
          return DropdownMenuItem<SpeciesData>(
            value: value,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value.enType,
                  style: FontStyle().textStyle(
                    color: !BreedsTypeCubit.get(context).isDark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String? dropdownClinicId;
  Widget buildDropDownClinic(List<Clinics> allClinicData, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8),
        color: !BreedsTypeCubit.get(context).isDark
            ? Colors.grey.shade400
            : Colors.white10,
      ),
      child: DropdownButton<Clinics>(
        underline: const SizedBox(),
        iconSize: 18,
        iconEnabledColor: Colors.black,
        borderRadius: BorderRadius.circular(20),
        dropdownColor: !BreedsTypeCubit.get(context).isDark
            ? Colors.white
            : Colors.grey.shade900,
        hint: Text(
          dropdownValueClinic ?? S.of(context).yourClinic,
        ),
        onChanged: (newValue) {
          setState(() {
            dropdownValueClinic = newValue!.name;
            dropdownClinicId = newValue!.clinicId!;
          });
        },
        items: allClinicData.map((Clinics value) {
          return DropdownMenuItem<Clinics>(
            value: value,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Text(
                value.name,
                style: FontStyle().textStyle(
                  color: !BreedsTypeCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    super.key,
    required this.scaffoldKey,
  });
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          const Spacer(),
          MaterialButton(
            onPressed: () {
              PostCubit.get(context).getPostImage().then((value) {
                scaffoldKey.currentState!.closeDrawer();
              });
            },
            shape: const CircleBorder(),
            child: const Card(
              elevation: 10,
              shape: CircleBorder(),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: CachedNetworkImageProvider(
                    'https://img.freepik.com/premium-vector/yellow-camera-with-paw-print-it_695276-3064.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=ais'),
              ),
            ),
          ),
          const Divider(),
          MaterialButton(
            onPressed: () {
              PostCubit.get(context).getPostCamera().then((value) {
                scaffoldKey.currentState!.closeDrawer();
              });
            },
            shape: const CircleBorder(),
            child: const Card(
              elevation: 10,
              shape: CircleBorder(),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: CachedNetworkImageProvider(
                  'https://img.freepik.com/premium-vector/cute-cat-with-camera-cartoon-vector-illustration_607277-199.jpg?w=826',
                ),
              ),
            ),
          ),
          const Divider(),
          MaterialButton(
            onPressed: () {
              PostCubit.get(context).getPostVideo().then((value) {
                scaffoldKey.currentState!.closeDrawer();
              });
            },
            shape: const CircleBorder(),
            child: const Card(
              elevation: 10,
              shape: CircleBorder(),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: CachedNetworkImageProvider(
                    'https://img.freepik.com/premium-photo/fun-dog-3d-illustration_183364-96472.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais'),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

Future sendNotification(String topic, String name) async {
  final data = {
    'to': '/topics/$topic',
    'notification': {
      'body': 'Notification Form $name',
      'title': 'Come to know what\'s new from $name',
    }
  };
  final result = await http.post(
    Uri.parse(baseUrlMessageKey),
    body: jsonEncode(data),
    headers: {'Content-type': 'application/json', 'Authorization': messageKey},
  );
  if (result.statusCode == 200) {
    print(await result.body);
  } else {
    print(result.reasonPhrase);
  }
}
