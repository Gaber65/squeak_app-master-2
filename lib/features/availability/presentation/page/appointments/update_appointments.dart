import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/availability/presentation/control/appointments/appointments_cubit.dart';
import 'package:squeak/features/availability/presentation/control/appointments/appointments_state.dart';

import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/components/styles.dart';
import '../../../../../core/widgets/elevated_button.dart';
import '../../../../../core/widgets/my_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../layout/layout.dart';
import '../../../../layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import '../../../domain/entities/Appointments/update_appointments_entities.dart';

class UpdateAppointment extends StatefulWidget {
  UpdateAppointment({Key? key, required this.appointments}) : super(key: key);
  Appointments appointments;
  @override
  State<UpdateAppointment> createState() => _UpdateAppointmentState();
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  var appointmentController = TextEditingController();
  var commentController = TextEditingController();
  var petController = TextEditingController();
  var doctorController = TextEditingController();

  @override
  void initState() {
    commentController.text = widget.appointments.visitComment;
    petController.text = widget.appointments.pet!.petName;
    doctorController.text = widget.appointments.doctor!.fullName;
    appointmentController.text = widget.appointments.appointmentTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AppointmentsCubit>(),
      child: BlocConsumer<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          if (state is UpdateAppointmentsSuccess) {
            AppointmentsCubit.get(context).getAppointments();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LayoutScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).updateAppointment),
            ),
            body: buildBody(widget.appointments, context, state),
          );
        },
      ),
    );
  }

  var formKey = GlobalKey<FormState>();

  Widget buildBody(Appointments appointments, context, AppointmentsState state) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(
                        '$imageUrl${appointments.pet!.imageName}')),
              ),
              const SizedBox(height: 24),
              blackBoldText(S.of(context).generalInformation),
              textField(
                S.of(context).petName,
                Icons.pets,
                petController,
                'd',
                enabled: false,
              ),
              textField(
                S.of(context).doctorName,
                Icons.person,
                doctorController,
                'd',
                enabled: false,
              ),
              InkWell(
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
                  label: appointments.appointmentDate.substring(0, 10),
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
              textField(
                S.of(context).editComment,
                IconlyLight.message,
                commentController,
                'd',
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              ConditionalBuilder(
                condition: state is! UpdateAppointmentsLoading,
                builder: (context) {
                  return MyElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AppointmentsCubit.get(context).updateAppointments(
                          petId: appointments.petId,
                          doctorId: appointments.doctorId,
                          availabilityId: appointments.availabilityId,
                          visitComment: commentController.text,
                          appointmentTime: appointmentController.text,
                          appointmentDate: appointments.appointmentDate,
                          appointmentsId: appointments.id,
                        );
                      }
                    },
                    colors: appColorBtn,
                    text: S.of(context).updateAppointment,
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
