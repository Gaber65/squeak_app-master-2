import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/features/availability/presentation/control/availabilities/availabilities_cubit.dart';
import 'package:squeak/features/availability/presentation/control/availabilities/availabilities_state.dart';

import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/elevated_button.dart';
import '../../../../../core/widgets/my_form_field.dart';
import '../../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../../domain/entities/availabilities/create_availabilities_entities.dart';

class EditAvailability extends StatefulWidget {
  EditAvailability({
    super.key,
    required this.clinicId,
    required this.availabilities,
  });
  Availabilities availabilities;
  String clinicId;

  @override
  State<EditAvailability> createState() => _EditAvailabilityState();
}

class _EditAvailabilityState extends State<EditAvailability> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var endController = TextEditingController();
  var timeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  int endTime = 0;
  int startTime = 0;
  int selectedIndex = 0;
  onSelected(int index) {
    setState(
      () => selectedIndex = index,
    );
  }

  int? enumAvailabilities = 1;
  final weekdayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  void initState() {
    endController.text = widget.availabilities.endTime;
    timeController.text = widget.availabilities.startTime;
    enumAvailabilities = widget.availabilities.dayOfWeek;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AvailabilitiesCubit>(),
      child: BlocConsumer<AvailabilitiesCubit, AvailabilitiesState>(
        listener: (context, state) {
          if (state is UpdateAvailabilitiesSuccess) {
            AvailabilitiesCubit.get(context)
                .getAvailabilities(clinicId: widget.clinicId);
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text('Edit Availabilities'),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is UpdateAvailabilitiesLoading)
                  const LinearProgressIndicator(),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 50,
                        )),
                  ),
                  const Text("Day Of Week"),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: const Divider(
                          color: Colors.black,
                          height: 50,
                        )),
                  ),
                ]),
                CarouselSlider.builder(
                  itemBuilder: (context, index, realIndex) {
                    enumAvailabilities = index;
                    return Container(
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Colors.red.shade300
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: Text(
                        weekdayNames[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                  itemCount: weekdayNames.length,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      onSelected(index);
                      print(index);
                    },
                    height: 100.0,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.2,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _buildLoginDetail(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginDetail(context, AvailabilitiesState state) {
    return Center(
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 70),
          decoration: BoxDecoration(
            color: BreedsTypeCubit.get(context).isDark
                ? Colors.grey
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
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 50,
                      )),
                ),
                const Text("Your Available Time"),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 50,
                      )),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    timeController.text =
                        '${value!.hour.toString().padLeft(2, '0')}:${value!.minute.toString().padLeft(2, '0')}:00';
                    print(value.format(context));
                    startTime = value.hour;
                    print(startTime);
                  });
                },
                child: MyFormField(
                  controller: timeController,
                  type: TextInputType.emailAddress,
                  enable: false,
                  label: 'Start Time',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please add Start Time';
                    }
                    return null;
                  },
                  isUpperCase: false,
                  suffix: const Icon(Icons.start),
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    endController.text =
                        '${value!.hour.toString().padLeft(2, '0')}:${value!.minute.toString().padLeft(2, '0')}:00';
                    print(value.hour);
                    endTime = value.hour;
                    print(endTime);
                  });
                },
                child: MyFormField(
                  enable: false,
                  controller: endController,
                  type: TextInputType.phone,
                  label: 'End Time',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please add End Time';
                    }
                    return null;
                  },
                  isUpperCase: false,
                  suffix: const Icon(Icons.av_timer),
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 30),
              ConditionalBuilder(
                condition: state is! UpdateAvailabilitiesLoading,
                builder: (context) {
                  return MyElevatedButton(
                    onPressed: () {
                      print(endController.text);
                      print(timeController.text);
                      print(widget.clinicId);
                      print(enumAvailabilities);
                      print(widget.availabilities.id);
                      if (formKey.currentState!.validate()) {
                        if (startTime < endTime || startTime == endTime) {
                          AvailabilitiesCubit.get(context).updateAvailabilities(
                            dayOfWeek: enumAvailabilities!,
                            startTime: timeController.text,
                            endTime: endController.text,
                            clinicId: widget.clinicId,
                            availabilitiesId: widget.availabilities.id,
                          );
                        } else {
                          showToast(
                              text: 'Please Add Correct Time',
                              state: ToastState.error);
                        }
                      }
                    },
                    colors: Colors.red,
                    text: 'Send Available',
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
      ),
    );
  }
}
