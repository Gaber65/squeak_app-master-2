import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/features/availability/presentation/control/appointments/appointments_cubit.dart';
import 'package:squeak/features/availability/presentation/control/appointments/appointments_state.dart';
import 'package:squeak/features/availability/presentation/page/appointments/update_appointments.dart';

import '../../../../../core/main_basic/main_basic.dart';
import '../../../../../core/network/end-points.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/components/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/Appointments/update_appointments_entities.dart';

class DoctorAppointment extends StatelessWidget {
  const DoctorAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return sl<AppointmentsCubit>()..getDoctorAppointments();
      },
      child: BlocConsumer<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          if (state is DeleteAppointmentsSuccess) {
            AppointmentsCubit.get(context).getAppointments();
          }
        },
        builder: (context, state) {
          var cubit = AppointmentsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).yourUpcomingAppointments),
            ),
            body: Column(
              children: [
                if (state is GetAppointmentsSuccess &&
                    cubit.appointmentsDoctorEntities!.appointmentsDate.count !=
                        0)
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return buildDetailsContent(
                            cubit.appointmentsDoctorEntities!.appointmentsDate
                                .appointments[index],
                            context);
                      },
                      itemCount: cubit.appointmentsDoctorEntities!
                          .appointmentsDate.appointments.length,
                    ),
                  ),
                if (state is GetAppointmentsSuccess &&
                    cubit.appointmentsDoctorEntities!.appointmentsDate.count ==
                        0)
                  Center(
                    child: CachedNetworkImage(
                        imageUrl:
                            'https://img.freepik.com/premium-vector/veterinary-doctor-with-mascot-character_24877-23260.jpg?size=626&ext=jpg&ga=GA1.1.131510781.1692744483&semt=ais'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDetailsContent(Appointments appointments, context) {
    return Card(
      elevation: 3,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          style: BorderStyle.none,
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: appColorBtn,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(14),
                  topStart: Radius.circular(14),
                )),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            isArabic()
                                ? 'تذكرة بموعد '
                                : 'Request Appointment for',
                            style: FontStyle().textStyle(
                              color: const Color.fromRGBO(245, 245, 245, .8),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${appointments.pet!.petName}',
                            style: FontStyle().textStyle(
                              color: const Color.fromRGBO(245, 245, 245, .8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(
                            IconlyBold.time_circle,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            appointments.appointmentDate.substring(0, 10),
                            style: FontStyle().textStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            ' , ${appointments.appointmentTime}',
                            style: FontStyle().textStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                        "$imageUrl${appointments.pet!.imageName}"),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        appointments.doctor!.fullName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(IconlyLight.location),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          appointments.doctor!.address,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
