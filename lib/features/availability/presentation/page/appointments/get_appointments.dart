import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/features/availability/presentation/page/appointments/update_appointments.dart';
import 'package:squeak/features/layout/presentation/screens/nav/specialistInfoPage.dart';

import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/service/service_locator.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/Appointments/update_appointments_entities.dart';
import '../../control/appointments/appointments_cubit.dart';
import '../../control/appointments/appointments_state.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AppointmentsCubit>()..getAppointments(),
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
              title: Text(
                S.of(context).yourAppointments,
                style: const TextStyle(fontFamily: 'bold', fontSize: 18),
              ),
              centerTitle: false,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is DeleteAppointmentsLoading)
                  const LinearProgressIndicator(),
                if (cubit.appointmentsEntities != null)
                  if (cubit.appointmentsEntities!.appointmentsDate.count != 0)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildDetailsContent(
                              cubit.appointmentsEntities!.appointmentsDate
                                  .appointments[index],
                              context,
                              cubit,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                        itemCount: cubit.appointmentsEntities!.appointmentsDate
                            .appointments.length,
                      ),
                    ),
                if (cubit.appointmentsEntities != null)
                  if (state is GetAppointmentsSuccess &&
                      cubit.appointmentsEntities!.appointmentsDate.count == 0)
                    CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/nurse-app-9f535.appspot.com/o/3905531-removebg-preview.png?alt=media&token=ad26c19b-0e57-416b-85d1-d1c993041c93&_gl=1*1l2cpod*_ga*MTAxNjc4MDIzNy4xNjkyNjQ5NzEy*_ga_CW55HF8NVT*MTY5Nzg3NzMzNi41OC4xLjE2OTc4NzczNjcuMjkuMC4w',
                    ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDetailsContent(
      Appointments appointments, context, AppointmentsCubit cubit) {
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
                                ? 'تذكرة بموعدك ل'
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
                CircleAvatar(
                  radius: 35,
                  backgroundImage: CachedNetworkImageProvider(
                      "$imageUrl${appointments.doctor!.imageName}"),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Text(
                        appointments.doctor!.fullName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    if (appointments.doctor!.address != null)
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
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateAppointment(appointments: appointments),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.green.shade100.withOpacity(.4),
                      elevation: 0,
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      )),
                    ),
                    child: Text(
                      isArabic() ? 'تعديل الموعد' : 'Edit Appointment',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(isArabic()
                                ? 'تأكيد الالغاء'
                                : "Cancel Confirmation"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    "${isArabic() ? 'هل أنت متأكد أنك تريد إلغاء الموعد ل' : 'Are you sure you want to cancel Appointment to'} ${appointments.pet!.petName}"),
                                const CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      'https://img.freepik.com/free-vector/emotional-support-animal-concept-illustration_114360-19462.jpg?w=740&t=st=1693530236~exp=1693530836~hmac=754f0eea1ad76b4cfe66e8f471927ff6d1d2c6625ff14e6cb2c81aa69ab9fc90'),
                                  radius: 75,
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.green,
                                    backgroundColor:
                                        Colors.green.shade100.withOpacity(.4),
                                    elevation: 0,
                                    shape: (RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    )),
                                  ),
                                  child: Text(
                                    isArabic() ? 'لا' : 'Back',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    cubit.deleteAppointments(
                                        appointmentsId: appointments.id);
                                    Navigator.of(context).pop(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    backgroundColor:
                                        Colors.red.shade100.withOpacity(.4),
                                    elevation: 0,
                                    shape: (RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    )),
                                  ),
                                  child: Text(
                                    isArabic() ? 'نعم' : 'Confirm',
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.red.shade100.withOpacity(.4),
                      elevation: 0,
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      )),
                    ),
                    child: Text(
                      isArabic() ? 'الغاء' : 'cancel',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
