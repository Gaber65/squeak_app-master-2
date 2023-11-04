import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/main_basic/main_basic.dart';

import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/widgets/my_form_field.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/beeds_type_data.dart';
import 'package:squeak/features/setting/update_profile/domain/entities/species_entities.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/add_edit_beets_state.dart';
import 'package:squeak/features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import 'package:squeak/features/setting/update_profile/presentation/pages/my_pets.dart';

import '../../../../../core/network/helper/helper_cubit.dart';
import '../../../../../core/network/helper/helper_model/helper_model.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/elevated_button.dart';
import '../../../../../core/widgets/toast_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../layout/layout.dart';
import '../../../../layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../controlls/cubit/add_edit_beets_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class AddPetDetail extends StatefulWidget {
  static const String id = 'AddPetDetail';
  String dropdownValueSpecies;
  String species;
  String pathImage;
  AddPetDetail(
      {Key? key,
      required this.dropdownValueSpecies,
      required this.pathImage,
      required this.species})
      : super(key: key);

  @override
  AddPetDetailState createState() => AddPetDetailState();
}

class AddPetDetailState extends State<AddPetDetail> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddBeetsCubit>()
        ..getBreedBySpeciesId(speciesId: widget.species)
        ..getAllSpecies(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return sl<AddBeetsCubit>()
                ..getBreedBySpeciesId(speciesId: widget.species)
                ..getAllSpecies();
            },
          ),
          BlocProvider(
            create: (context) {
              return sl<HelperCubit>();
            },
          ),
        ],
        child: BlocConsumer<AddBeetsCubit, AddBeetsState>(
          listener: (context, state) {
            if (state is SqueakPitsImagePickedSuccessState) {
              HelperCubit.get(context).getGlobalImage(
                file: state.file,
                uploadPlace: UploadPlace().petsImages,
              );
            }
            if (state is SqueakAddPetsSuccessState) {
              if (state.addNewPetData.success) {
                BreedsTypeCubit.get(context).getOwnerPits();
                AddBeetsCubit.get(context).pitsImage = null;
                namePetController.clear();
                showToast(
                  text: state.addNewPetData.message,
                  state: ToastState.success,
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyPets(),
                    ));
              } else {
                showToast(
                  text: state.addNewPetData.errors!.values.first[0],
                  state: ToastState.error,
                );
              }
            }
          },
          builder: (context, state) {
            var cubit = AddBeetsCubit.get(context);
            return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    S.of(context).addPet,
                  ),
                ),
                body: SingleChildScrollView(child: _buildBody(cubit, context, state)));
          },
        ),
      ),
    );
  }

  Widget _buildBody(AddBeetsCubit cubit, context, AddBeetsState state) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: cubit.pitsImage == null
                        ? CachedNetworkImageProvider(widget.pathImage)
                            as ImageProvider
                        : FileImage(cubit.pitsImage!),
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
                          cubit.getPitsImage();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(S.of(context).generalInformation),
            const SizedBox(height: 20),
            TextFormField(
              controller: namePetController,
              focusNode: FocusNode(),
              maxLines: 1,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: appColor,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: appColor,
                  ),
                ),
                filled: true,
                hintText: '${S.of(context).petName}',
                suffixIcon: const Icon(
                  Icons.pets,
                  color: appColorBtn,
                  size: 22.0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).breed),
                    const SizedBox(
                      height: 18,
                    ),
                    (cubit.breedSpecies != null)
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: buildDropDownBreed(
                              cubit.breedSpecies!.data!,
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(8),
                              color: !BreedsTypeCubit.get(context).isDark
                                  ? Colors.black12
                                  : Colors.white10,
                            ),
                          ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).species),
                    const SizedBox(
                      height: 18,
                    ),
                    (cubit.speciesEntities != null)
                        ? buildDropDownSpecies(
                            cubit.speciesEntities!.data!, context)
                        : Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(8),
                              color: !BreedsTypeCubit.get(context).isDark
                                  ? Colors.black12
                                  : Colors.white10,
                            ),
                          ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Text(S.of(context).gender),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: buildSelect(isArabic() ? "ذكر" : 'Male', 1)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: buildSelect(isArabic() ? 'أنثى' : 'Female', 2)),
              ],
            ),
            const SizedBox(height: 8),
            Text(isArabic() ? 'تاريخ الميلاد' : 'date of birth'),
            const SizedBox(height: 20),

            buildSelectDate2(),
            const SizedBox(height: 30),
            BlocConsumer<AddBeetsCubit, AddBeetsState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: state is! SqueakAddPetsLoadingState,
                  builder: (context) {
                    return MyElevatedButton(
                      onPressed: () {
                        validation(cubit);
                        if (dropdownIdBreed == null) {
                          showToast(
                            text: "The Breed is required",
                            state: ToastState.error,
                          );
                        } else if (cubit.formKey.currentState!.validate()) {}
                        cubit.addPetsFire(
                          petName: namePetController.text,
                          gender: selectID,
                          birthdate: currentDate!.toString().substring(0, 10),
                          breedId: dropdownIdBreed!,
                        );
                        cubit.addPets(
                          petName: namePetController.text,
                          gender: selectID,
                          birthdate: currentDate.toString().substring(0, 10),
                          breedId: dropdownIdBreed!,
                          image: HelperCubit.get(context).modelImage!.data!,
                        );
                      },
                      colors: appColorBtn,
                      text: S.of(context).save,
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
    );
  }

  int selectID = 1;
  String dropdownValueBreed = '';
  String? dropdownIdBreed;

  DateTime? currentDate;
  var namePetController = TextEditingController();
  List<SpeciesData> speciesDataList = [];
  List<BreadData> breadData = [];
  String? timeDate = DateTime.now().toString().substring(0, 10);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        timeDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
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
          border: Border.all(style: BorderStyle.none),
          color: selectID == id ? appColorBtn : appColorBtn.withOpacity(.3),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'medium',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildDropDownSpecies(List<SpeciesData> speciesData, context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8),
        color: !BreedsTypeCubit.get(context).isDark
            ? Colors.black12
            : Colors.white10,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<SpeciesData>(
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(8),
          dropdownColor: !BreedsTypeCubit.get(context).isDark
              ? Colors.white
              : Colors.grey.shade900,
          iconSize: 18,
          iconEnabledColor: Colors.black,
          hint: Text(widget.dropdownValueSpecies),
          onChanged: (newValue) {
            setState(
              () {
                widget.dropdownValueSpecies = newValue!.enType;
                widget.species = newValue.id;
                AddBeetsCubit.get(context).breedSpecies!.data!.clear();
                AddBeetsCubit.get(context)
                    .getBreedBySpeciesId(speciesId: newValue.id);
              },
            );
          },
          items: speciesData.map((SpeciesData value) {
            return DropdownMenuItem<SpeciesData>(
              value: value,
              child: Text(
                value.enType,
                style: FontStyle().textStyle(
                  color: !BreedsTypeCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildDropDownBreed(List<BreadData> breedData) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8),
        color: !BreedsTypeCubit.get(context).isDark
            ? Colors.black12
            : Colors.white10,
      ),
      child: DropdownButton<BreadData>(
        underline: const SizedBox(),
        iconSize: 18,
        menuMaxHeight: 300,
        iconEnabledColor: Colors.black,
        borderRadius: BorderRadius.circular(8),
        dropdownColor: !BreedsTypeCubit.get(context).isDark
            ? Colors.white
            : Colors.grey.shade900,
        hint: SizedBox(
          width: MediaQuery.of(context).size.width / 2.6,
          child: Text(
            dropdownValueBreed,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            dropdownValueBreed = newValue!.enType;
            dropdownIdBreed = newValue.id;
            print('${newValue.id}555555555555555555555555555');
          });
        },
        items: breedData.map((BreadData value) {
          return DropdownMenuItem<BreadData>(
            value: value,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.6,
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



  Widget buildSelectDate2() {
    return InkWell(
      onTap: () => _selectDate(context),

      child: TextFormField(
        enabled: false,
        focusNode: FocusNode(),
        maxLines: 1,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: appColor,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: appColor,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: appColor,
            ),
          ),
          filled: true,
          hintText: timeDate!,
          suffixIcon: const Icon(
            Icons.calendar_month,
            color: appColorBtn,
            size: 22.0,
          ),
        ),
      ),
    );
  }

  validation(AddBeetsCubit cubit) {
    if (namePetController.text.isEmpty) {
      showToast(
        text: "The pet name is required",
        state: ToastState.error,
      );
      return;
    }
    if (cubit.pitsImage == null) {
      showToast(
        text: "The pet image is required",
        state: ToastState.error,
      );
      return;
    }
    if (currentDate == null) {
      showToast(
        text: "The Pet birthdate is required",
        state: ToastState.error,
      );
    }
  }
}
