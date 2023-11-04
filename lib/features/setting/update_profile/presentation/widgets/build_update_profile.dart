import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/resources/values_manager.dart';
import 'package:squeak/core/widgets/national_phone.dart';
import 'package:squeak/features/setting/profile/domain/entities/profile.dart';
import '../../../../../core/network/helper/helper_cubit.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/elevated_button.dart';
import '../../../../layout/layout.dart';
import '../../../../layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../../../../layout/presentation/controller/Home_cubit/squeak_state.dart';

class BuildUpdateProfile extends StatefulWidget {
  final Profile model;

  const BuildUpdateProfile({Key? key, required this.model}) : super(key: key);

  @override
  State<BuildUpdateProfile> createState() => _BuildUpdateProfileState();
}

class _BuildUpdateProfileState extends State<BuildUpdateProfile> {
  var formKey = GlobalKey<FormState>();

  var fullName = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  String? timeDate;
  int selectID = 1;

  @override
  void initState() {
    fullName.text = widget.model.data!.fullName;
    phone.text = widget.model.data!.phone;
    timeDate = widget.model.data!.birthdate.toString();
    address.text = widget.model.data!.address;
    selectID = widget.model.data!.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SqueakCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<HelperCubit>(),
        )
      ],
      child: BlocConsumer<SqueakCubit, SqueakState>(
        listener: (context, state) {
          if (state is SqueakUpdateProfileSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LayoutScreen();
                },
              ),
              (route) => false,
            );
          }

          if (state is SqueakProfileImagePickedSuccessState) {
            HelperCubit.get(context).getGlobalImage(
              file: state.file,
              uploadPlace: UploadPlace().usersImages,
            );
          }
        },
        builder: (context, state) {
          var cubit = SqueakCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                  AppPadding.p20,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocConsumer<HelperCubit, HelperState>(
                        builder: (context, state) {
                          if (state is ImageHelperLoading) {
                            return LinearProgressIndicator();
                          } else {
                            return SizedBox();
                          }
                        },
                        listener: (context, state) {},
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: cubit.profileImage == null
                                  ? CachedNetworkImageProvider(
                                      '$imageUrl${widget.model.data!.imageName}',
                                    ) as ImageProvider
                                  : FileImage(cubit.profileImage!),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 15,
                              ),
                              child: CircleAvatar(
                                radius: 15,
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt_outlined),
                                  iconSize: 15,
                                  onPressed: () {
                                    cubit.getProfileImage().then((value) {
                                      print(
                                          '=============================== response ============================');
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      TextFormField(
                        controller: fullName,
                        focusNode: FocusNode(),
                        maxLines: 1,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: appColor,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: appColor,
                            ),
                          ),
                          filled: true,
                          suffixIcon: Icon(
                            Icons.person,
                            color: appColorBtn,
                            size: 22.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      IntlPhoneNumber(
                        controller: phone,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      TextFormField(
                        controller: address,
                        focusNode: FocusNode(),
                        maxLines: 1,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: appColor,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: appColor,
                            ),
                          ),
                          hintText: 'Address',
                          filled: true,
                          suffixIcon: Icon(
                            Icons.location_on_sharp,
                            color: appColorBtn,
                            size: 22.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text('Gender'),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: buildSelect('Male', 1)),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(child: buildSelect('Female', 2)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      const Text(
                        'Date of birth',
                        textAlign: TextAlign.left,
                      ),
                      _buildSelectDate(),
                      const SizedBox(
                        height: AppSize.s50,
                      ),
                      BlocConsumer<SqueakCubit, SqueakState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return ConditionalBuilder(
                            condition:
                                state is! SqueakUpdateProfileLoadingState,
                            builder: (context) {
                              return MyElevatedButton(
                                onPressed: () {
                                  print(address.text);
                                  print(fullName.text);
                                  print(phone.text.length);
                                  print(selectID);
                                  cubit.getUpdateProfile(
                                    email: widget.model.data!.email,
                                    fullName: fullName.text,
                                    phone: phone.text!.length == 10
                                        ? '0${phone.text}'
                                        : phone.text,
                                    imageName:
                                        HelperCubit.get(context).modelImage ==
                                                null
                                            ? widget.model.data!.imageName
                                            : HelperCubit.get(context)
                                                .modelImage!
                                                .data!,
                                    address: address.text,
                                    gender: selectID,
                                    birthdate: timeDate!,
                                    userType: widget.model.data!.role,
                                    userName: widget.model.data!.userName,
                                  );
                                },
                                colors: appColorBtn,
                                text: 'Save',
                              );
                            },
                            fallback: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        timeDate =
            "${pickedDate.day} / ${pickedDate.month} / ${pickedDate.year}";
      });
    }
  }

  Widget _buildSelectDate() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(timeDate!),
            const Icon(Icons.calendar_month, color: appColorBtn)
          ],
        ),
      ),
    );
  }

  Widget buildSelect(title, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectID = id;
        });
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: selectID == id ? appColorBtn : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'medium',
                fontSize: 14,
                color: selectID == id ? Colors.white : Colors.black54)),
      ),
    );
  }
}
