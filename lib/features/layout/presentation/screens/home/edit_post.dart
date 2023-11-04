import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/resources/constants_manager.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../../../../core/network/end-points.dart';
import '../../../../../core/network/helper/helper_cubit.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/components/styles.dart';
import '../../../../../core/widgets/elevated_button.dart';
import '../../../../../core/widgets/video_detail.dart';
import '../../../../../generated/l10n.dart';
import '../../../../setting/profile/presentation/pages/doctor_posts.dart';
import '../../../../setting/update_profile/domain/entities/species_entities.dart';
import '../../../../setting/update_profile/presentation/controlls/cubit/add_edit_beets_cubit.dart';
import '../../../../setting/update_profile/presentation/controlls/cubit/add_edit_beets_state.dart';
import '../../../domain/entites/clinic/all_clinics_entities.dart';
import '../../../domain/entites/post/create_post_entites.dart';
import '../../controller/post_cubit/post_cubit.dart';
import '../clinic/clinic_cubit/clinic_cubit.dart';

class EditPost extends StatefulWidget {
  EditPost({
    super.key,
    required this.clinicPost,
    required this.postItem,
    required this.image,
  });
  ClinicPost clinicPost;
  Posts postItem;
  String image;
  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  List<SpeciesData> speciesDataList = [];

  String? dropdownValueSpecies;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var postTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    postTextController.text = widget.postItem!.content;
  }

  @override
  void dispose() {
    postTextController.dispose();
    super.dispose();
  }

  bool _isRTL(String text) {
    final rtlRegex = RegExp(r'[\u0600-\u06FF]|[\u0750-\u077F]|[\u0590-\u05FF]');
    return rtlRegex.hasMatch(text);
  }

  String? dropdownValueClinic;
  bool isRTL = false;
  var formKey = GlobalKey<FormState>();
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

      child: BlocProvider(
        create: (context) => sl<PostCubit>(),
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {
            if (state is PostImagePickedSuccessState) {
              HelperCubit.get(context).getGlobalImage(
                file: state.file,
                uploadPlace: UploadPlace().postImages,
              );
            }
            if (state is UpdatePostSuccessState) {
              AddBeetsCubit.get(context).getAllSpecies();
              PostCubit.get(context).getAllDoctorPost().then(
                (value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DoctorPost(),
                    ),
                    (route) => false,
                  );
                },
              );
            }
          },
          builder: (context, state) {
            var cubit = PostCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              drawer: DrawerWidget(scaffoldKey: scaffoldKey),
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorPost(),
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
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(
                          'https://img.freepik.com/premium-vector/phone-with-checkmark-line-icon-approval-approved-tick-check-checked-done-examination-verification-test-antivirus-technology-concept-vector-line-icon-business-advertising_399089-5958.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=ais'),
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(90),
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
                            return (AddBeetsCubit.get(context)
                                .speciesEntities !=
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
                                color:
                                !BreedsTypeCubit.get(context).isDark
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
                                ? buildDropDownClinic( ClinicCubit.get(context)
                                .allClinicSupplierEntities!
                                .data!
                                .clinics,
                                context
                            )
                                : Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadiusDirectional.circular(8),
                                color:
                                !BreedsTypeCubit.get(context).isDark
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
                      if (widget.image != '')
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  4.0,
                                ),
                                image: DecorationImage(
                                  image: PostCubit.get(context).postImage == null
                                      ? CachedNetworkImageProvider(
                                          '$imageUrl${widget.postItem.image}')
                                      : FileImage(
                                              PostCubit.get(context).postImage!)
                                          as ImageProvider,
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
                                PostCubit.get(context).removePostImage();
                                HelperCubit.get(context).modelImage = null;
                                widget.image = '';
                                print(widget.image);
                                setState(() {});
                              },
                            ),
                          ],
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
                        condition: state is! UpdatePostLoadingState,
                        builder: (context) {
                          return MyElevatedButton(
                            onPressed: () {
                              print(dropdownClinicId);
                              print(dropdownIdValue);
                              if (dropdownIdValue == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Select Species')));
                              }
                              if (dropdownClinicId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Select Clinic')));
                              }
                              if (formKey.currentState!.validate()) {
                                cubit.updatePost(
                                  title: DateTime.now().toString(),
                                  content: postTextController.text,
                                  image:
                                      HelperCubit.get(context).modelImage == null
                                          ? widget.image
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
                                  postId: widget.postItem.postId,
                                );
                              }
                            },
                            text: 'Publish',
                            colors: appColorBtn,
                          );
                        },
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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
         border: InputBorder.none
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
        hint: Text(dropdownValueSpecies ?? widget.postItem.speciePost!.enType),
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
              child: Text(
                value.enType,
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
          dropdownValueClinic ?? widget.postItem.clinicPost!.name,
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
