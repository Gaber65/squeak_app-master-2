import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/models/appointment_model/appointment_model.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_cubit.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_state.dart';
import 'package:mostakbal/feature/appointment/view/screens/Booking-done.dart';
import 'package:mostakbal/feature/appointment/view/screens/booking-step1-screen.dart';
import 'package:mostakbal/feature/home_page/search_favourite/view/screens/search_screen.dart';

import '../../../../core/const/components/elevated_button.dart';
import '../../../../core/const/const.dart';

class BookingScreen1 extends StatelessWidget {
  const BookingScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit()
        ..getAppointment(context)
        ..getCancledAppointment(context)
        ..getCompleteAppointment(context),
      child: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppointmentCubit.get(context);
          return DefaultTabController(
            length: 3,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(
                    'الحجوزات',
                    style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        RoutePage().navigateTo(context, SearchScreen());
                      },
                      icon: Icon(
                        IconlyLight.search,
                        color: ColorStyle().primaryColor,
                      ),
                    ),
                  ],
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(40),
                      child: buildTabBarItem()),
                ),
                body: TabBarView(
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return buildPaddingOtherOffers(
                          context,
                          cubit.appointmentDataSource.addAppoinment[index],
                          cubit.appointmentDataSource.ids[index],
                        );
                      },
                      itemCount:
                          cubit.appointmentDataSource.addAppoinment.length,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return bulidCompleteBokking(
                            context,
                            cubit.appointmentDataSource
                                .addAppoinmentCompleted[index]);
                      },
                      itemCount: cubit
                          .appointmentDataSource.addAppoinmentCompleted.length,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return bulidRemoveBooking(
                          context,
                          cubit.appointmentDataSource
                              .addAppoinmentCancled[index],
                        );
                      },
                      itemCount: cubit
                          .appointmentDataSource.addAppoinmentCancled.length,
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  Padding buildPaddingOtherOffers(
    BuildContext context,
    AppointmentModel appointmentModel,
    String id,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: MediaQuery.sizeOf(context).width,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.white,
          elevation: 1,
          surfaceTintColor: Colors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  appointmentModel.hotialImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appointmentModel.hotialName,
                          style: FontStyle().textStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              appointmentModel.startDate.substring(5, 11)
                                  as String,
                              style: FontStyle().textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.grey,
                              ),
                            ),
                            Text(
                              ' - ',
                              style: FontStyle().textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.grey,
                              ),
                            ),
                            Text(
                              appointmentModel.endDate.substring(5, 11)
                                  as String,
                              style: FontStyle().textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.grey,
                              ),
                            ),
                            const Icon(
                              IconlyLight.calendar,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          'مدفوع',
                          style: GoogleFonts.tajawal(
                              fontSize: 14, color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookingDone(
                            appointmentModel: appointmentModel,
                          );
                        }));
                      },
                      child: Material(
                        color: ColorStyle().primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'عرض الذكرة',
                            style: FontStyle().textStyle(
                              fontSize: 12,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        _showCustomDialog(
                            context,
                            id,
                            appointmentModel.fullName,
                            appointmentModel.userName,
                            appointmentModel.birthdate,
                            appointmentModel.email,
                            appointmentModel.phone,
                            appointmentModel.numOfAdults,
                            appointmentModel.numOfYoung,
                            appointmentModel.endDate,
                            appointmentModel.startDate,
                            appointmentModel.hotialImage,
                            appointmentModel.hotialName);
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            ' الغاء الرحلة',
                            style: FontStyle().textStyle(
                              fontSize: 12,
                              fontColor: Colors.red,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding bulidCompleteBokking(
      BuildContext context, AppointmentModel appointmentModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: MediaQuery.sizeOf(context).width,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.white,
          elevation: 1,
          surfaceTintColor: Colors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  appointmentModel.hotialImage,
                  width: 103,
                  height: 127,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appointmentModel.hotialName,
                          style: FontStyle().textStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ('${appointmentModel.startDate}')
                                  .substring(5, 11),
                              style: FontStyle().textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.grey,
                              ),
                            ),
                            Text(
                              ' - ',
                              style: FontStyle().textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.grey,
                              ),
                            ),
                            Text(
                              ('${appointmentModel.endDate}').substring(5, 11),
                              style: FontStyle().textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.grey,
                              ),
                            ),
                            const Icon(
                              IconlyLight.calendar,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          'تم اكتمال الحجز',
                          style: GoogleFonts.tajawal(
                              fontSize: 14, color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookingStep1Screen(
                            hotialName: appointmentModel.hotialName,
                            hotialImage: appointmentModel.hotialImage,
                          );
                        }));
                      },
                      child: Material(
                        color: ColorStyle().primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            ' حجز مره اخري',
                            style: FontStyle().textStyle(
                              fontSize: 12,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding bulidRemoveBooking(
      BuildContext context, AppointmentModel appointmentModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: MediaQuery.sizeOf(context).width,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.white,
          elevation: 1,
          surfaceTintColor: Colors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  appointmentModel.hotialImage,
                  width: 103,
                  height: 127,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appointmentModel.hotialName,
                          style: FontStyle().textStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ('${appointmentModel.startDate}')
                                  .substring(5, 11),
                              style: FontStyle().textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.grey,
                              ),
                            ),
                            Text(
                              ' - ',
                              style: FontStyle().textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.grey,
                              ),
                            ),
                            Text(
                              ('${appointmentModel.endDate}').substring(5, 11),
                              style: FontStyle().textStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontColor: Colors.grey,
                              ),
                            ),
                            const Icon(
                              IconlyLight.calendar,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          'تم الغاء الحجز',
                          style: GoogleFonts.tajawal(
                              fontSize: 14, color: Colors.red),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BookingStep1Screen(
                            hotialImage: appointmentModel.hotialImage,
                            hotialName: appointmentModel.hotialName,
                          );
                        }));
                      },
                      child: Material(
                        color: ColorStyle().primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            ' اعادة الحجز',
                            style: FontStyle().textStyle(
                              fontSize: 12,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabBarItem() {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(250, 250, 250, 1),
          borderRadius: BorderRadius.circular(8)),
      child: TabBar(
        labelColor: ColorStyle().primaryColor,
        unselectedLabelColor: Color.fromRGBO(161, 165, 193, 1),
        labelStyle: FontStyle().textStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          fontColor: ColorStyle().primaryColor,
        ),
        unselectedLabelStyle: FontStyle().textStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          fontColor: Colors.grey,
        ),
        indicatorColor: ColorStyle().primaryColor,
        isScrollable: true,
        tabs: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              'الحالية',
              style: GoogleFonts.tajawal(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              ' مكتملة',
              style: GoogleFonts.tajawal(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              ' ملغية',
              style: GoogleFonts.tajawal(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomDialog(
    BuildContext context,
    String id,
    String fullNmae,
    String username,
    String birthdate,
    String email,
    String phone,
    int numOfAdults,
    int numOfYoung,
    dynamic endDate,
    dynamic startDate,
    String hotialImage,
    String hotialName,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => AppointmentCubit(),
          child: BlocConsumer<AppointmentCubit, AppointmentState>(
            listener: (context, state) {
              if (state is AddCancledAppointmentSuccess) {
                AppointmentCubit().deleteAppointment(id: id);
              }
            },
            builder: (context, state) {
              var cubit=AppointmentCubit.get(context);

              return Dialog(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/squeak-chat.appspot.com/o/photo_6003435162874002505_m.jpg?alt=media&token=ad94418d-c7b6-4904-9eae-e1a769e62ae0',
                          height: 150,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'هل تريد بالفعل إلغاء الحجز ؟',
                          style: FontStyle().textStyle(
                            fontSize: 14,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Divider(),

                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                                  shape: (RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                                ),
                                child: Text(
                                  'الغاء',
                                  style: FontStyle().textStyle(
                                    fontColor: ColorStyle().primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4,),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  cubit.addCancledAppointment(fullNmae: '',
                                      username: username,
                                      birthdate: '',
                                      email: email, phone: phone,
                                      numOfAdults: numOfAdults,
                                      numOfYoung: numOfYoung,
                                      endDate: endDate,
                                      startDate: startDate,
                                      hotialImage: hotialImage,
                                      hotialName: hotialName,
                                      context: context);

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorStyle().primaryColor,
                                  shape: (RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                                ),
                                child: Text(
                                  'نعم, متابعة',
                                  style: FontStyle().textStyle(
                                    fontSize: 14,
                                    fontColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
