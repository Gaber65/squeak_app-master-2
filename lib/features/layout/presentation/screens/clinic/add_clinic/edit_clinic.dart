import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/resources/constants_manager.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/widgets/my_form_field.dart';
import 'package:squeak/core/widgets/national_phone.dart';
import 'package:squeak/features/layout/layout.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import 'package:squeak/generated/l10n.dart';
import '../../../../../../core/network/end-points.dart';
import '../../../../../../core/network/helper/helper_cubit.dart';
import '../../../../../../core/network/helper/helper_model/helper_model.dart';
import '../../../../../../core/service/service_locator.dart';
import '../../../../../../core/widgets/elevated_button.dart';

import '../../../../../../core/widgets/toast_state.dart';
import '../../../../../setting/profile/presentation/pages/doctor_posts.dart';
import '../../../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../domain/entites/clinic/all_clinic_follower.dart';
import '../../../../domain/entites/clinic/all_clinics_entities.dart';
import '../../../../domain/entites/clinic/speciality_entities.dart';
import '../follow_clinic/clinic_follower.dart';

class EditClinic extends StatefulWidget {
  EditClinic({Key? key, required this.clinicId, required this.clinics})
      : super(key: key);
  String clinicId;
  Clinics clinics;

  @override
  State<EditClinic> createState() => _EditClinicState();
}

class _EditClinicState extends State<EditClinic> {
  var nameClinicController = TextEditingController();
  var locationClinicController = TextEditingController();
  var cityClinicController = TextEditingController();
  var addressClinicController = TextEditingController();
  var phoneClinicController = TextEditingController();
  var specialityClinicController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var codeClinicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameClinicController.text = widget.clinics.name;
    locationClinicController.text = widget.clinics.location;
    cityClinicController.text = widget.clinics.name;
    addressClinicController.text = widget.clinics.address;
    phoneClinicController.text = widget.clinics.phone;
    codeClinicController.text = widget.clinics.code;
    specialitiesId = widget.clinics.speciality.first.id;
  }

  List<SpecialitiesData> speciesDataList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ClinicCubit>(),
      child: BlocConsumer<ClinicCubit, ClinicState>(
        listener: (context, state) {
          if (state is PickImageClinicSuccessState) {
            HelperCubit.get(context).getGlobalImage(
                file: state.path, uploadPlace: UploadPlace().clinicImage);
          }
          if (state is SqueakAddNewClinicFireSuccessState) {
            ClinicCubit.get(context).getAllSupplierClinics();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorPost(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = ClinicCubit.get(context);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(isArabic()
                  ? "تعديل المورد الخاص بك "
                  : ' Edit Your Supplier'),
            ),
            body: _buildBody(context, state),
            floatingActionButton: FloatingActionButton(
              backgroundColor: appColorBtn,
              onPressed: () {
                cubit.getCurrentPosition(context).then((value) {
                  locationClinicController.text = cubit.currentLocation!;
                  cityClinicController.text = cubit.currentCity!;
                  addressClinicController.text = cubit.currentAddress!;
                });
              },
              child: const Icon(Icons.location_on),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(context, ClinicState state) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          _buildProfile(context, state),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: _buildLoginDetail(context, state),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile(context, ClinicState state) {
    return ClinicCubit.get(context).clinicImage == null
        ? Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        '$imageUrl${widget.clinics.image}'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  child: IconButton(
                    onPressed: () {
                      ClinicCubit.get(context).getClinicImage();
                    },
                    icon: const Icon(
                      Icons.camera_enhance_outlined,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: FileImage(ClinicCubit.get(context).clinicImage!),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    ClinicCubit.get(context).removePostImage();
                  },
                  icon: const CircleAvatar(
                    child: Icon(
                      Icons.delete_rounded,
                    ),
                  ))
            ],
          );
  }

  String exception =
      'Code must have at least 1 uppercase letter, 1 lowercase letter, and 1 number.';
  Widget _buildLoginDetail(context, ClinicState state) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 70),
        decoration: BoxDecoration(
          color: BreedsTypeCubit.get(context).isDark
              ? ThemeData.dark().scaffoldBackgroundColor
              : Colors.white60,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Column(
          children: [
            MyFormField(
              controller: nameClinicController,
              type: TextInputType.emailAddress,
              label: S.of(context).ServiceName,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Service Name';
                } else if (value.length < 2) {
                  return "Supplier Name more than 6 charts";
                }
                return null;
              },
              suffix: const Icon(
                IconlyLight.shield_done,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MyFormField(
              controller: codeClinicController,
              type: TextInputType.emailAddress,
              label: S.of(context).uniqueCode,
              validator: (value) {
                final pattern =
                    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{3,}$');
                if (!pattern.hasMatch(value!)) {
                  return exception;
                }
                return null;
              },
              suffix: const Icon(
                Icons.qr_code_2_sharp,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            IntlPhoneNumber(
              controller: phoneClinicController,
            ),
            const SizedBox(
              height: 20,
            ),
            buildDropDownSpecies(
                ClinicCubit.get(context).specialitiesEntities!),
            const SizedBox(
              height: 20,
            ),
            MyFormField(
              label: S.of(context).location,
              suffix: const Icon(
                Icons.location_searching_sharp,
              ),
              controller: locationClinicController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please add Click on Location Button';
                }
                return null;
              },
              type: TextInputType.text,
            ),
            const SizedBox(
              width: 2,
            ),
            MyFormField(
              label: S.of(context).city,
              suffix: const Icon(
                Icons.reduce_capacity_outlined,
              ),
              controller: cityClinicController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please add Click on Location Button';
                }
                return null;
              },
              type: TextInputType.text,
            ),
            const SizedBox(
              width: 2,
            ),
            MyFormField(
              label: S.of(context).address,
              suffix: const Icon(
                Icons.contact_mail_outlined,
              ),
              controller: addressClinicController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please add Click on Location Button';
                }
                return null;
              },
              type: TextInputType.text,
            ),
            const SizedBox(height: 30),
            ConditionalBuilder(
              condition: state is! SqueakAddNewClinicFireLoadingState,
              builder: (context) {
                return MyElevatedButton(
                  onPressed: () {
                    print(phoneClinicController.text!.length);
                    ClinicCubit.get(context).updateClinic(
                      name: nameClinicController.text,
                      phone: phoneClinicController.text!.length == 10
                          ? '0${phoneClinicController.text}'
                          : phoneClinicController.text,
                      speciality: specialitiesId,
                      image: ClinicCubit.get(context).clinicImage == null
                          ? widget.clinics.image
                          : HelperCubit.get(context).modelImage!.data!,
                      clinicId: widget.clinicId,
                      code: codeClinicController.text,
                      currentAddress: addressClinicController.text,
                      currentCity: cityClinicController.text,
                      currentLocation: locationClinicController.text,
                    ).then((value) {
                      showToast(
                        text: "Service Edit Successfully",
                        state: ToastState.success,
                      );
                      ClinicCubit.get(context).clinicImage = null;
                      nameClinicController.clear();
                      phoneClinicController.clear();
                      locationClinicController.clear();
                      addressClinicController.clear();
                      cityClinicController.clear();
                    });
                  },
                  colors: appColorBtn,
                  text: 'Service location',
                );
              },
              fallback: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String? dropdownValueSpecies;
  String specialitiesId = '';

  Widget buildDropDownSpecies(List<SpecialitiesData> specialitiesData) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8),
        color: !BreedsTypeCubit.get(context).isDark
            ? Colors.grey.shade400
            : Colors.white10,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<SpecialitiesData>(
          underline: const SizedBox(),
          iconSize: 18,
          borderRadius: BorderRadius.circular(20),
          dropdownColor: !BreedsTypeCubit.get(context).isDark
              ? Colors.white
              : Colors.grey.shade900,
          iconEnabledColor: Colors.black,
          hint: Text(
              dropdownValueSpecies ?? widget.clinics.speciality.first.name),
          onChanged: (newValue) {
            setState(() {
              dropdownValueSpecies = newValue!.name;
              specialitiesId = newValue.id;
              print(specialitiesId);
            });
          },
          items: specialitiesData.map((SpecialitiesData value) {
            return DropdownMenuItem<SpecialitiesData>(
              value: value,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
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
      ),
    );
  }
}
