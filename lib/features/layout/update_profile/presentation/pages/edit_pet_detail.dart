/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squeak/components/styles.dart';
import 'package:squeak/core/resources/color_manager.dart';
import 'package:squeak/core/widgets/circularImageBorder.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/features/layout/update_profile/cubit/add_edit_beets_cubit.dart';
import 'package:squeak/features/layout/update_profile/cubit/add_edit_beets_state.dart';
import 'package:squeak/features/layout/update_profile/cubit/beets_type_find_cubit.dart';
import 'package:squeak/features/layout/update_profile/cubit/beets_type_find_states.dart';
import 'package:squeak/features/layout/update_profile/data/model/beeds_type_model.dart';

import '../../data/model/find_pet_by_owner_id_model.dart';

class EditPetDetail extends StatefulWidget {
  static const String id = 'AddPetDetail';
  final String petId;

  const EditPetDetail({Key? key, required this.petId}) : super(key: key);

  @override
  _AddPetDetailState createState() => _AddPetDetailState();
}

class _AddPetDetailState extends State<EditPetDetail> {
  int selectID = 1;
  final ImagePicker _picker = ImagePicker();
  late File? image = null;
  String dropdownValueSpecies = 'Dog';
  String dropdownValueBreed = '';
  late Breed breed;
  int typeID = 0;
  String breedID = "";
  String breedType = "";
  String imageUrl = "";
  List<Pets> petsList = [];

  String gender = "1";
  String dropdownValueSize = 'Select';
  DateTime currentDate = DateTime.now();
  late String timeDate = "";

  var nameController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        timeDate = pickedDate.day.toString() +
            " / " +
            pickedDate.month.toString() +
            " / " +
            pickedDate.year.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    BeedstypeCubit.get(context).FindPetById(widget.petId);
  }

  List<Breed> BreedDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: appColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Edit pet detail',
            style: TextStyle(color: Colors.black, fontFamily: 'bold'),
          ),
          actions: [TextButton(onPressed: () {}, child: appcolorText('Skip'))],
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: BlocConsumer<BeedstypeCubit, BreedTypeStates>(
        listener: (context, state) {
          if (state is GetPetDataSuccessState) {
            print(state.response.toString());
            petsList.clear();
            petsList.addAll(state.response.data!.pets!.cast<Pets>());
            BeedstypeCubit.get(context).speciesId(petsList[0]!.species!);
            typeID = petsList[0]!.species!;
            if (petsList[0]!.species! == 1) {
              dropdownValueSpecies = "Dog";
            }
            if (petsList[0]!.species! == 2) {
              dropdownValueSpecies = "Cat";
            }
            gender = "${petsList[0]!.gender!}";
            selectID = petsList[0]!.gender!;
            timeDate = petsList[0]!.birthdate!;
            typeID = petsList[0]!.species!;
            breedID = petsList[0]!.breedId!;
            imageUrl = petsList[0]!.imageName!;
            breedType = petsList[0]!.breedName!;
            nameController.text = petsList[0]!.petName!;
          }

          // TODO: implement listener
        },
        builder: (context, state) {

          if(state is GetPetDataLoadingState){

            return Center(child: CircularProgressIndicator(),);

          }

          return Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: image == null
                                ? circularImageBorderCustom(
                                    boxfit: BoxFit.fill,
                                    image: imageUrl,
                                    raduis: 50,
                                    width: 130,
                                    height: 150,
                                    bottomMargin: 2,
                                    leftMargin: 2,
                                    rightMargin: 2,
                                    topMargin: 2)
                                : circularImageBorderCustomfile(
                                    boxfit: BoxFit.fill,
                                    image: image!,
                                    raduis: 50,
                                    width: 130,
                                    height: 150,
                                    bottomMargin: 2,
                                    leftMargin: 2,
                                    rightMargin: 2,
                                    topMargin: 2),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: ColorManager.bBlack,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt_outlined),
                              onPressed: () {
                                addImage();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const Center(
                //   child: CircleAvatar(
                //     radius: 46,
                //     backgroundImage: AssetImage('assets/images/pet.jpg'),
                //   ),
                // ),
                const SizedBox(height: 24),
                blackBoldText('General information'),
                textField('Pet\'s Name', Icons.check, nameController),
                const SizedBox(height: 8),
                greyTextSmall('Species of your pet'),
                buildDropDownSpecies(),
                const SizedBox(height: 8),
                greyTextSmall('Breed'),
                BlocConsumer<BeedstypeCubit, BreedTypeStates>(
                  listener: (context, state) {
                    if (state is BreedTypeSuccessState) {
                      BreedDataList.addAll(
                          state.response.data!.breed!.cast<Breed>());
                    }
                  },
                  builder: (context, state) {
                    return buildDropDownBreed(BreedDataList);
                  },
                ),
                const SizedBox(height: 8),
                // greyTextSmall('Size(optional)'),
                // buildDropDownSize(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    greyTextSmall('Gender'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSelect('Male', 1),
                        _buildSelect('Female', 2),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                greyTextSmall('Date of birth'),
                _buildSelectDate(),
                const SizedBox(height: 30),

                BlocConsumer<AddBeetsCubit, AddBeetsState>(
                  listener: (context, state) {
                    if (state is EditPetResponseSuccessState) {
                      showToast(
                        text: state.response.message!,
                        state: ToastState.success,
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                    if (state is EditPetResponseErrorState) {
                      showToast(
                        text: state.error.title!,
                        state: ToastState.error,
                      );
                    }

                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return MyElevatedButton(
                        onPressed: () {
                          Validation();

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const TabsExample()));
                        },
                        colors: appColor,
                        text: 'Save');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelect(title, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectID = id;
          gender = selectID.toString();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: selectID == id ? appColor : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Text(title,
            style: TextStyle(
                fontFamily: 'medium',
                fontSize: 14,
                color: selectID == id ? Colors.white : Colors.black54)),
      ),
    );
  }

  Widget buildDropDownSpecies() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26)),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        iconSize: 18,
        iconEnabledColor: Colors.black,
        value: dropdownValueSpecies,
        onChanged: (newValue) {
          setState(() {
            dropdownValueSpecies = newValue!;
            breedType = "";
            breedID = "";
            BreedDataList.clear();
            if (newValue.contains("Dog")) {
              BeedstypeCubit.get(context).speciesId(1);
              typeID = 1;
            }
            if (newValue.contains("Cat")) {
              BeedstypeCubit.get(context).speciesId(2);
              typeID = 2;
            }
          });
        },
        items: ['Dog', 'Cat'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildDropDownBreed(List<Breed> breedDataList) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26)),
        color: Colors.white,
      ),
      child: DropdownButton<Breed>(
        underline: const SizedBox(),
        hint: Text(breedType),
        iconSize: 18,
        iconEnabledColor: Colors.black,
        onChanged: (newValue) {
          setState(() {
            dropdownValueBreed = newValue!.breedName!;
            breedType = newValue!.breedName!;
            breed = newValue;
            breedID = newValue.id!;
          });
        },
        items: breedDataList.map((Breed value) {
          return DropdownMenuItem<Breed>(
            value: value,
            child: Text(value.breedName!),
          );
        }).toList(),
      ),
    );
  }

  Widget buildDropDownSize() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26)),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        iconSize: 18,
        iconEnabledColor: Colors.black,
        value: dropdownValueSize,
        onChanged: (newValue) {
          setState(() {
            dropdownValueSize = newValue!;
          });
        },
        items: ['Select', '5', '6', '7']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSelectDate() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  Text(currentDate.toString()),
            Text(timeDate,
                style: TextStyle(
                    fontFamily: 'medium', fontSize: 14, color: Colors.black54)),
            Icon(Icons.calendar_month, color: appColor)
          ],
        ),
      ),
    );
  }

  void addImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imagepath = File(image.path);
      setState(() {
        this.image = imagepath;
      });
    } on PlatformException catch (e) {}

    if (image != null) {
      setState(() {});
    }
  }

  Validation() {
    if (nameController.text.isEmpty) {
      showToast(
        text: "name is empty",
        state: ToastState.error,
      );
      return;
    }
    if (image == null && imageUrl.isEmpty) {
      showToast(
        text: "image is empty",
        state: ToastState.error,
      );
      return;
    }
    if (breedID.isEmpty) {
      showToast(
        text: "breed is empty",
        state: ToastState.error,
      );
      return;
    }
    if (timeDate.isEmpty) {
      showToast(
        text: "date is empty",
        state: ToastState.error,
      );
      return;
    }
    apiCall();
  }

  apiCall() async {
    AddBeetsCubit.get(context).EditPet(
        petId: widget.petId,
        Breedid: breedID,
        Birthdate: timeDate,
        Gender: gender,
        PetName: nameController.text,
        Species: typeID.toString(),
        image: image);
  }
}
