import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/widgets/toast_state.dart';

import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/components/styles.dart';
import '../../../../../core/widgets/elevated_button.dart';

import '../../../../../generated/l10n.dart';
import 'compomnents/record_components.dart';

import 'package:intl/intl.dart';

import '../../../../setting/update_profile/domain/entities/vaccination_entities.dart';
import 'vac_cubit/vaccination_cubit.dart';

class PetVaccination extends StatelessWidget {
  PetVaccination({
    Key? key,
    required this.gender,
    required this.petName,
    required this.petId,
  }) : super(key: key);

  String petName;
  String petId;
  int gender;

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var commentController = TextEditingController();

  Future<void> _selectDate(BuildContext context, VaccinationCubit cubit) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: cubit.currentDateItem!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != cubit.currentDateItem) {
      cubit.changeSelectDate(
        currentDate: pickedDate,
        timeDate:
            "${pickedDate.day} / ${pickedDate.month} / ${pickedDate.year}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<VaccinationCubit>()
        ..getVaccinationName()
        ..createDatabase(petId)
        ..getVacPet(petId: petId),
      child: BlocConsumer<VaccinationCubit, VaccinationState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = VaccinationCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                S.of(context).addRecord,
              ),
            ),
            body: buildConditional(
                task: VaccinationCubit.get(context).list,
                petId: petId,
                commentController: commentController,
                contextBloc: context),
            floatingActionButton: FloatingActionButton(
              backgroundColor: appColorBtn,
              child: Icon(cubit.isButtonSheetShown ? Icons.add : Icons.edit),
              onPressed: () {
                cubit.changeBottomSheetShow(isShow: cubit.isButtonSheetShown);
              },
            ),
            bottomSheet: cubit.isButtonSheetShown
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildDropDownBreed(cubit.vacEntities!.data!, context),
                          buildSelectDate(context, cubit),
                          textField(
                            S.of(context).addComment,
                            IconlyLight.message,
                            commentController,
                            'Please add Comment',
                            maxLines: 3,
                          ),
                          const SizedBox(height: 30),
                          MyElevatedButton(
                            onPressed: () {
                              if (cubit.valueVacItem == "Select Service") {
                                showToast(
                                  text: 'Please select Your service',
                                  state: ToastState.warning,
                                );
                              } else if (cubit.timeDateItem == null) {
                                showToast(
                                  text: 'Please select a service Date ',
                                  state: ToastState.warning,
                                );
                              } else if (formKey.currentState!.validate()) {
                                VaccinationCubit.get(context).insertToDatabase(
                                  comments: commentController.text,
                                  pitName: petName,
                                  typeVaccination: cubit.valueVacItem!,
                                  gender: gender,
                                  data: cubit.currentDateItem
                                      .toString()
                                      .substring(0, 10),
                                  petId: petId,
                                );
                                VaccinationCubit.get(context).createVac(
                                  comments: commentController.text ?? '',
                                  pitName: petName,
                                  typeVaccination: cubit.valueVacItem!,
                                  gender: gender,
                                  data: cubit.currentDateItem
                                      .toString()
                                      .substring(0, 10),
                                  petId: petId,
                                  typeId: cubit.valueIdItem,
                                  statues: false,
                                );
                                VaccinationCubit.get(context)
                                    .changeBottomSheetShow(isShow: true);
                              }
                            },
                            colors: Colors.red,
                            text: S.of(context).addRecord,
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget buildDropDownBreed(List<VacEntitiesData> vacEntitiesData, context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26)),
        color: Colors.white,
      ),
      child: DropdownButton<VacEntitiesData>(
        underline: const SizedBox(),
        iconSize: 18,
        menuMaxHeight: 200,
        iconEnabledColor: Colors.black,
        hint: Text(VaccinationCubit.get(context).valueVacItem),
        onChanged: (newValue) {
          VaccinationCubit.get(context).changeSelect(
            vacName: newValue!.vaccinationName,
            vacId: newValue.id,
          );
          print(VaccinationCubit.get(context).valueIdItem);
          print(VaccinationCubit.get(context).valueVacItem);
        },
        items: vacEntitiesData.map((VacEntitiesData value) {
          return DropdownMenuItem<VacEntitiesData>(
            value: value,
            child: Text(
              value.vaccinationName,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildSelectDate(context, VaccinationCubit cubit) {
    return GestureDetector(
      onTap: () => _selectDate(context, cubit),
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
            Text(
                cubit.timeDateItem ??
                    cubit.currentDateItem.toString().substring(0, 10),
              ),
            const Icon(IconlyBold.calendar, color: appColorBtn)
          ],
        ),
      ),
    );
  }
}
