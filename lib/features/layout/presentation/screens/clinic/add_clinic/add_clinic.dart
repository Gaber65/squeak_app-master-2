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
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/clinic/clinic_cubit/clinic_cubit.dart';
import 'package:squeak/features/setting/profile/presentation/pages/doctor_posts.dart';
import '../../../../../../core/network/end-points.dart';
import '../../../../../../core/network/helper/helper_cubit.dart';
import '../../../../../../core/network/helper/helper_model/helper_model.dart';
import '../../../../../../core/service/service_locator.dart';
import '../../../../../../core/widgets/elevated_button.dart';

import '../../../../../../core/widgets/toast_state.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../domain/entites/clinic/speciality_entities.dart';
import '../../../../layout.dart';
import '../../../controller/post_cubit/post_cubit.dart';

class AddClinic extends StatefulWidget {
  const AddClinic({Key? key}) : super(key: key);

  @override
  State<AddClinic> createState() => _AddClinicState();
}

class _AddClinicState extends State<AddClinic> {
  var nameClinicController = TextEditingController();
  var codeClinicController = TextEditingController();
  var locationClinicController = TextEditingController();
  var cityClinicController = TextEditingController();
  var addressClinicController = TextEditingController();
  var phoneClinicController = TextEditingController();
  var specialityClinicController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  List<SpecialitiesData> speciesDataList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ClinicCubit>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<ClinicCubit>()..getAllSpeciality(),
          ),
          BlocProvider(
            create: (context) => sl<HelperCubit>(),
          ),
        ],
        child: BlocConsumer<ClinicCubit, ClinicState>(
          listener: (context, state) {
            if (state is PickImageClinicSuccessState) {
              HelperCubit.get(context).getGlobalImage(
                  file: state.path, uploadPlace: UploadPlace().clinicImage);
            }
            if (state is SqueakAddNewClinicSuccessState) {
              if (state.addClinicEntities.success) {
                showToast(
                  text: state.addClinicEntities.message,
                  state: ToastState.success,
                );
                ClinicCubit.get(context).getAllSupplierClinics();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorPost(),
                  ),
                  (route) => false,
                );

                ClinicCubit.get(context).clinicImage = null;
                HelperCubit.get(context).modelImage = null;
                nameClinicController.clear();
                phoneClinicController.clear();
                locationClinicController.clear();
                addressClinicController.clear();
                cityClinicController.clear();
              } else {
                showToast(
                  text: state.addClinicEntities.errors!.values.first[0],
                  state: ToastState.success,
                );
              }
            }
          },
          builder: (context, state) {
            var cubit = ClinicCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  S.of(context).addPetService,
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LayoutScreen();
                        },
                      ),
                      (route) => false,
                    );
                  },
                  icon: Icon(
                    isArabic()
                        ? IconlyLight.arrow_right_2
                        : IconlyLight.arrow_left_2,
                  ),
                ),
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

  String image =
      'https://img.freepik.com/free-vector/hepatologist-online-service-platform-doctor-make-liver-examination-hepatectomy-idea-medical-treatment-online-appointment-isolated-vector-illustration_613284-888.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=ais';
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
                    image: CachedNetworkImageProvider(image),
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
      'Code must be at 4 Numbers and have a mixture of uppercase and lowercase';
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
              condition: state is! SqueakAddNewClinicLoadingState,
              builder: (context) {
                return MyElevatedButton(
                  onPressed: () {
                    if (HelperCubit.get(context).modelImage == null) {
                      showToast(
                        text: "Image is required",
                        state: ToastState.error,
                      );
                      return;
                    }
                    if (codeClinicController.text.isEmpty) {
                      showToast(
                        text: exception,
                        state: ToastState.error,
                      );
                      return;
                    }

                    if (formKey.currentState!.validate() &&
                        ClinicCubit.get(context).clinicImage != null) {
                      print(phoneClinicController.text!.length);
                      ClinicCubit.get(context).addNewClinic(
                        name: nameClinicController.text,
                        phone: phoneClinicController.text!.length == 10
                            ? '0${phoneClinicController.text}'
                            : phoneClinicController.text,
                        speciality: specialitiesId,
                        image: HelperCubit.get(context).modelImage!.data!,
                        code: codeClinicController.text,
                        currentLocation: locationClinicController.text,
                        currentCity: cityClinicController.text,
                        currentAddress: addressClinicController.text,
                      );
                    }
                  },
                  colors: appColorBtn,
                  text: S.of(context).addPetService,
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

  String dropdownValueSpecies = '';
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
          hint: Text(dropdownValueSpecies),
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
