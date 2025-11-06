import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostakbal/core/const/components/elevated_button.dart';
import 'package:mostakbal/core/models/appointment_model/appointment_model.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_cubit.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_state.dart';
import 'package:mostakbal/feature/appointment/view/screens/Booking1-screen.dart';
import 'package:mostakbal/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/const/const.dart';

class BookingDone extends StatelessWidget {
  BookingDone({super.key, required this.appointmentModel});
  AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit(),
      child: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AddCompleteAppointmentSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const BookingScreen1();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = AppointmentCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'التذكرة',
                style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ColorStyle().primaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        QrImageView(
                          backgroundColor: ColorStyle().primaryColor,
                          foregroundColor: Colors.white,
                          data: uId,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الاسم:',
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    appointmentModel.userName,
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'بدايه الحجز:',
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    appointmentModel.startDate,
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'الفندق',
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    appointmentModel.hotialName,
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'رقم الهاتف:',
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    appointmentModel.phone,
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'نهايه الحجز:',
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    appointmentModel.endDate,
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'عدد الافراد',
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    appointmentModel.numOfYoung.toString(),
                                    style: FontStyle().textStyle(
                                        fontSize: 12,
                                        fontColor: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MyElevatedButton(
                    onPressed: () {
                      cubit.addCompleteAppointment(
                        fullNmae: appointmentModel.fullName,
                        username: appointmentModel.userName,
                        birthdate: appointmentModel.birthdate,
                        email: appointmentModel.email,
                        phone: appointmentModel.phone,
                        numOfAdults: appointmentModel.numOfAdults,
                        numOfYoung: appointmentModel.numOfYoung,
                        endDate: appointmentModel.endDate,
                        startDate: appointmentModel.startDate,
                        hotialImage: appointmentModel.hotialImage,
                        hotialName: appointmentModel.hotialName,
                        context: context,
                      );
                    },
                    text: 'تحميل التذكرة',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
