import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/components/notifi_service.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/cubit/squeak_state.dart';

import '../../../components/styles.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utils/translation/applocal.dart';
import '../../../core/widgets/record_components.dart';
import 'package:intl/intl.dart';

class PetVaccination extends StatelessWidget {
  PetVaccination({Key? key, required this.gender, required this.pitName})
      : super(key: key);

  String pitName;
  int gender;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SqueakCubit>()..createDatabase(),
      child: BlocConsumer<SqueakCubit, SqueakState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SqueakCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                "${getLang(context, "addRecord")}",
              ),
            ),
            body: ConditionalBuilder(
              builder: (context) => buildAllRecord(context),
              condition: state is! AppGetDatabaseLoadingState,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: appColorBtn,
              child: Icon(cubit.isButtonSheetShown ? Icons.add : Icons.edit),
              onPressed: () {
                if (cubit.isButtonSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      time: timeController.text,
                      data: dateController.text,
                      pitName: pitName,
                      typeVaccination: titleController.text,
                      gender: gender,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        elevation: 7,
                        (context) => buildAddRecord(
                          context,
                          formKey,
                          titleController,
                          timeController,
                          dateController,
                          pitName,
                          gender,
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetShow(isShow: false);
                    titleController.clear();
                    timeController.clear();
                    dateController.clear();
                  });
                  cubit.changeBottomSheetShow(isShow: true);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
  required bool obscureText,
  Color? color,
  required String labelText,
  IconData? prefixIcon,
  Function()? OnTap,
  bool click = true,
  IconData? suffixIcon,
  Function()? suffixIconfun,
  required double redius,
  required String? Function(String?)? validator,
}) =>
    TextFormField(
      enabled: click,
      onTap: OnTap,
      obscureText: obscureText,
      validator: validator, // here it gives the error
      controller: controller,
      style: const TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      keyboardType: type,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          onPressed: suffixIconfun,
          icon: Icon(
            suffixIcon,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(redius),
          borderSide: const BorderSide(
            color: Colors.black87,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(redius),
          borderSide: const BorderSide(
            color: Colors.black87,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(redius),
          borderSide: const BorderSide(
            color: Colors.black87,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(redius),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );

Widget buildAllRecord(BuildContext context) {
  return buildConditional(
    task: SqueakCubit.get(context).newRecord,
  );
}

Padding buildAddRecord(
  BuildContext context,
  formKey,
  titleController,
  timeController,
  dateController,
  pitName,
  gender,
) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultTextForm(
            type: TextInputType.emailAddress,
            obscureText: false,
            labelText: "${getLang(context, "NameOfRecord")}",
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter valid value';
              } else {
                return null;
              }
            },
            redius: 12,
            controller: titleController,
            prefixIcon: Icons.vaccines_outlined,

          ),
          const SizedBox(
            height: 15,
          ),
          defaultTextForm(
            OnTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((value) {
                timeController.text = value!.format(context).toString();
                print(value.format(context));
              });
            },
            type: TextInputType.datetime,
            obscureText: false,
            labelText: "${getLang(context, "DateOfRecord")}",
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter valid value';
              } else {
                return null;
              }
            },
            prefixIcon: Icons.access_time_sharp,
            redius: 12,
            controller: timeController,
          ),
          const SizedBox(
            height: 15,
          ),
          defaultTextForm(
            type: TextInputType.datetime,
            controller: dateController,
            OnTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.parse('2025-10-12'),
              ).then((value) {
                dateController.text = DateFormat.yMMMd().format(value!);

                print(value);
              });
            },
            obscureText: false,
            labelText: '${getLang(context, "TimeOfRecord")}',
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter valid value';
              } else {
                return null;
              }
            },
            prefixIcon: Icons.calendar_today_outlined,
            redius: 12,
          ),
          const SizedBox(
            height: 12,
          ),
          MaterialButton(
            color: appColorBtn,
            minWidth: double.infinity,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                SqueakCubit.get(context).insertToDatabase(
                  pitName: pitName,
                  typeVaccination: titleController.text,
                  gender: gender,
                  time: timeController.text,
                  data: dateController.text,
                );
                Navigator.pop(context);
                SqueakCubit.get(context).changeBottomSheetShow(isShow: false);
              }
            },
            child: const Text(
              "Add Record",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
