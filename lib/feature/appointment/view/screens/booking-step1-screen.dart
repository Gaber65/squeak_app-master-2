import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_cubit.dart';
import 'package:mostakbal/feature/appointment/controller/appointment_state.dart';
import 'package:mostakbal/feature/appointment/view/main-pay-screen.dart';
import 'package:mostakbal/feature/profile-feature/controller/setting_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingStep1Screen extends StatefulWidget {
  String? hotialName;
  String? hotialImage;
  BookingStep1Screen({required this.hotialName, required this.hotialImage});

  @override
  State<BookingStep1Screen> createState() => _BookingStep1ScreenState();
}

class _BookingStep1ScreenState extends State<BookingStep1Screen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;
  var daycontroller1 = TextEditingController();
  var daycontroller2 = TextEditingController();
  var daycontroller3 = TextEditingController();
  var daycontroller4 = TextEditingController();

  DateTime? _selectedDate;
  DateTime? _selectedDate2;

  void _selectWeek(DateTime selectedDay) {
    setState(() {
      _selectedStartDay = selectedDay;
      _selectedEndDay = selectedDay.add(Duration(days: 9));
    });
  }

  Future<void> _selectDateTime1(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        daycontroller1.text =
            "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}";
      });
    }
  }

  Future<void> _selectDateTime2(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate2) {
      setState(() {
        _selectedDate2 = picked;
        daycontroller2.text =
            "${_selectedDate2!.day}-${_selectedDate2!.month}-${_selectedDate2!.year}";
      });
    }
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppointmentCubit()
            ..getCompleteAppointment(context)
            ..getCancledAppointment(context)
            ..getCancledAppointment(context),
        ),
        BlocProvider(
          create: (context) => SettingCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AddAppointmentSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MainPayScreen();
            }));
          }
        },
        builder: (context, state) {
          var cubit = AppointmentCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          '  تاريخ الحجز',
                          style: GoogleFonts.tajawal(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) {
                          return _selectedStartDay != null &&
                              _selectedEndDay != null &&
                              day.isAfter(_selectedStartDay!
                                  .subtract(Duration(days: 1))) &&
                              day.isBefore(
                                  _selectedEndDay!.add(Duration(days: 1)));
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          _selectWeek(selectedDay);
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'من يوم',
                                    style: GoogleFonts.tajawal(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 180,
                                  ),
                                  Text(
                                    'الي يوم',
                                    style: GoogleFonts.tajawal(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      controller: daycontroller1,
                                      keyboardType: TextInputType.phone,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك ادخل اليوم';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        FocusScope.of(context).requestFocus(
                                            new FocusNode()); // Hide keyboard
                                        _selectDateTime1(context);
                                      },
                                      keyboardAppearance: Brightness.dark,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              // cubit.changePasswordVisibility();
                                            },
                                            icon: Icon(
                                              IconlyLight.calendar,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: .2, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      controller: daycontroller2,
                                      keyboardType: TextInputType.phone,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك ادخل اليوم';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        FocusScope.of(context).requestFocus(
                                            new FocusNode()); // Hide keyboard
                                        _selectDateTime2(context);
                                      },
                                      keyboardAppearance: Brightness.dark,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              // cubit.changePasswordVisibility();
                                            },
                                            icon: Icon(
                                              IconlyLight.calendar,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: .2, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ' عدد الكبار',
                                    style: GoogleFonts.tajawal(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 180,
                                  ),
                                  Text(
                                    ' عدد الصغار',
                                    style: GoogleFonts.tajawal(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      controller: daycontroller3,
                                      keyboardType: TextInputType.phone,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك ادخل اليوم';
                                        }
                                        return null;
                                      },
                                      keyboardAppearance: Brightness.dark,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              // cubit.changePasswordVisibility();
                                            },
                                            icon: Icon(
                                              IconlyLight.calendar,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: .2, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      controller: daycontroller4,
                                      keyboardType: TextInputType.phone,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك ادخل اليوم';
                                        }
                                        return null;
                                      },
                                      keyboardAppearance: Brightness.dark,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              // cubit.changePasswordVisibility();
                                            },
                                            icon: Icon(
                                              IconlyLight.calendar,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: .2, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'المبلغ المطلوب',
                            style: GoogleFonts.tajawal(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            '2400جنيه',
                            style: GoogleFonts.tajawal(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: MaterialButton(
                          onPressed: () {
                            String datatimeText = daycontroller1.text;
                            List<String> partsdata = datatimeText.split('-');
                            int daydata = int.parse(partsdata[0]);
                            int monthdata = int.parse(partsdata[1]);
                            int yeardata = int.parse(partsdata[2]);
                            DateTime parseddata =
                                DateTime(yeardata, monthdata, daydata);
                            String datatimeText2 = daycontroller2.text;
                            List<String> partsdata2 = datatimeText2.split('-');
                            int daydata2 = int.parse(partsdata[0]);
                            int monthdata2 = int.parse(partsdata[1]);
                            int yeardata2 = int.parse(partsdata[2]);
                            DateTime parseddata2 =
                                DateTime(yeardata2, monthdata2, daydata2);

                            if (formKey.currentState!.validate()) {
                              cubit.addAppointment(
                                  numOfAdults: int.parse(daycontroller4.text),
                                  hotialImage: widget.hotialImage!,
                                  username: SettingCubit.get(context)
                                      .settingDataSource
                                      .userDataModel!
                                      .userName,
                                  fullNmae: SettingCubit.get(context)
                                      .settingDataSource
                                      .userDataModel!
                                      .fullName,
                                  birthdate: SettingCubit.get(context)
                                      .settingDataSource
                                      .userDataModel!
                                      .birthdate,
                                  phone: SettingCubit.get(context)
                                      .settingDataSource
                                      .userDataModel!
                                      .phone,
                                  email: SettingCubit.get(context)
                                      .settingDataSource
                                      .userDataModel!
                                      .email,
                                  hotialName: widget.hotialName!,
                                  numOfYoung: int.parse(daycontroller3.text),
                                  endDate: parseddata2,
                                  startDate: parseddata,
                                  context: context);
                            }
                          },
                          child: Text(
                            ' متابعة',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
