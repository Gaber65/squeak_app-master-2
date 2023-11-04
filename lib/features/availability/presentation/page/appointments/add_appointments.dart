import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';
import 'package:squeak/core/resources/constants_manager.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/core/widgets/toast_state.dart';
import 'package:squeak/features/availability/presentation/control/appointments/appointments_cubit.dart';
import 'package:squeak/features/availability/presentation/control/appointments/appointments_state.dart';
import 'package:squeak/features/layout/layout.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_state.dart';

import '../../../../../core/network/end-points.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/my_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../setting/update_profile/domain/entities/find_pet_by_owner_id_data.dart';

class AddAppointments extends StatefulWidget {
  AddAppointments({
    Key? key,
    required this.doctorId,
    required this.availabilityId,
    required this.numOfDays,
  }) : super(key: key);

  String doctorId;
  int numOfDays;
  String availabilityId;

  @override
  State<AddAppointments> createState() => _AddAppointmentsState();
}

class _AddAppointmentsState extends State<AddAppointments> {
  double value = 10;
  var appointmentController = TextEditingController();
  var dateController = TextEditingController();
  var visitComment = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    switch (widget.numOfDays) {
      case 0:
        showToast(
          text: 'Please Choose Sunday',
          state: ToastState.success,
        );
        break;
      case 1:
        showToast(
          text: 'Please Choose Monday',
          state: ToastState.success,
        );
        break;
      case 2:
        showToast(
          text: 'Please Choose Tuesday',
          state: ToastState.success,
        );
        break;
      case 3:
        showToast(
          text: 'Please Choose Wednesday',
          state: ToastState.success,
        );
        break;
      case 4:
        showToast(
          text: 'Please Choose Thursday',
          state: ToastState.success,
        );
        break;
      case 5:
        showToast(
          text: 'Please Choose Friday',
          state: ToastState.success,
        );
        break;
      case 6:
        showToast(
          text: 'Please Choose Saturday',
          state: ToastState.success,
        );
        break;
      default:
        print('Not a known fruit.');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AppointmentsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SqueakCubit>()..getOwnerPits(),
        ),
      ],
      child: BlocConsumer<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          if (state is CreateAppointmentsSuccess) {
            if (state.createAppointmentsEntities.status) {
              AppointmentsCubit.get(context).getAppointments();
              Navigator.pop(context);
            } else {
              showToast(
                state: ToastState.warning,
                text: state.createAppointmentsEntities.errors.values.first[0]!,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = AppointmentsCubit.get(context);
          return Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state is CreateAppointmentsLoading)
                  LinearProgressIndicator(),
                Row(
                  children: [
                    Text(S.of(context).chosePet),
                    const Spacer(),
                    BlocConsumer<SqueakCubit, SqueakState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        var cubit = SqueakCubit.get(context);
                        return (cubit.ownerPetsEntities != null)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: buildDropDown(
                                  petsData: cubit.ownerPetsEntities!.data!,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 400),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade600,
                                    child: const CircleAvatar(),
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            appointmentController.text =
                                '${value!.hour.toString().padLeft(2, '0')}:${value!.minute.toString().padLeft(2, '0')}:00';
                            print(value.format(context));
                          });
                        },
                        child: MyFormField(
                          controller: appointmentController,
                          type: TextInputType.emailAddress,
                          enable: false,
                          label: S.of(context).time,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please add Appointment Time';
                            }
                            return null;
                          },
                          isUpperCase: false,
                          suffix: const Icon(Icons.watch_later_outlined),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            lastDate: DateTime(3000),
                            firstDate: DateTime.now(),
                          ).then((value) {
                            dateController.text =
                                value.toString().substring(0, 10);
                            print(value.toString().substring(0, 10));
                          });
                        },
                        child: MyFormField(
                          controller: dateController,
                          type: TextInputType.emailAddress,
                          enable: false,
                          label: S.of(context).date,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please add Appointment Time';
                            }
                            return null;
                          },
                          isUpperCase: false,
                          suffix: const Icon(Icons.calendar_month),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                MyFormField(
                  controller: visitComment,
                  type: TextInputType.emailAddress,
                  label: S.of(context).addComment,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please add Visit Comment';
                    }
                    return null;
                  },
                  isUpperCase: false,
                  suffix: Icon(IconlyLight.message),
                  fillColor: Colors.white,
                ),
                const SizedBox(
                  height: 12,
                ),
                MyElevatedButton(
                  onPressed: () {
                    print(dropDownId);
                    print(widget.doctorId);
                    print(widget.availabilityId);
                    print(visitComment.text);
                    print(appointmentController.text);
                    print(dateController.text);
                    if (formKey.currentState!.validate()) {
                      cubit
                          .createAppointments(
                        petId: dropDownId!,
                        doctorId: widget.doctorId,
                        availabilityId: widget.availabilityId,
                        visitComment: visitComment.text,
                        appointmentTime: appointmentController.text,
                        appointmentDate: dateController.text,
                      )
                          .then((value) {
                        Navigator.of(context).pop(true);
                      });
                    }
                  },
                  text: S.of(context).addAppointment,
                  colors: appColorBtn,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String? dropDownId;
  String? dropDown;
  Widget buildDropDown({required List<PetsData> petsData}) {
    return DropdownButton<PetsData>(
      onChanged: (newValue) {
        setState(() {
          var dropDown = '$imageUrl${newValue!.imageName}';
          dropDownId = newValue.petId;
          print(dropDownId);
          print(dropDown);
          showToast(
            text: 'Now you Acting By ${newValue.petName}',
            state: ToastState.success,
          );
        });
      },
      isExpanded: false,
      iconSize: 0.0,
      elevation: 0,
      icon: const SizedBox.shrink(),
      underline: const SizedBox(),
      hint: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
        dropDown ??
            'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
      )),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      items: petsData.map((PetsData value) {
        return DropdownMenuItem<PetsData>(
          value: value,
          child: CircleAvatar(
            radius: 20,
            backgroundImage:
                CachedNetworkImageProvider('$imageUrl${value.imageName}'),
          ),
        );
      }).toList(),
    );
  }
}
