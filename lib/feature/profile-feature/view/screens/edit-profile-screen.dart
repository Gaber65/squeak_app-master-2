import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:mostakbal/feature/profile-feature/chat-feature/cubit/chat-states.dart';
import 'package:mostakbal/feature/profile-feature/controller/setting_cubit.dart';
import 'package:mostakbal/feature/profile-feature/controller/setting_state.dart';
import '../../../../core/const/components/elevated_button.dart';
import '../../data_source/setting_data_source.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var phoneController = TextEditingController();

  var emailcontroller = TextEditingController();

  var nameController = TextEditingController();

  var birthdayController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        birthdayController.text =
            "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocProvider(
        create: (context) => SettingCubit()..getUserData(),
        child: BlocConsumer<SettingCubit, SettingState>(
          listener: (context, state) {
            var cubit = SettingCubit.get(context);
            if (state is SuccessGetUserdata) {
              Future<String> myMethod() async {
                await Future.delayed(const Duration(seconds: 1)).then(
                  (value) {
                    phoneController.text = cubit.settingDataSource.userDataModel!.phone;
                    birthdayController.text = cubit.settingDataSource.userDataModel!.birthdate.substring(0, 10);
                    nameController.text = cubit.settingDataSource.userDataModel!.fullName;
                    emailcontroller.text = cubit.settingDataSource.userDataModel!.email;
                  },
                ); // Simulating an asynchronous operation
                return 'Hello, World!';
              }

              myMethod();
            }

          },
          builder: (context, state) {
            var cubit = SettingCubit.get(context);
            return Scaffold(
                appBar: buildAppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: (cubit.profileImage == null)
                                  ? NetworkImage(
                                      cubit.settingDataSource.userDataModel ==
                                              null
                                          ? 'https://img.freepik.com/free-photo/blue-user-icon-symbol-website-admin-social-login-element-concept-white-background-3d-rendering_56104-1217.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph'
                                          : cubit.settingDataSource
                                              .userDataModel!.image,
                                    )
                                  : FileImage(cubit.profileImage!)
                                      as ImageProvider,
                            ),
                          ),
                          CircleAvatar(
                            child: IconButton(
                              onPressed: () {
                                cubit.getProfileImage();
                              },
                              icon: const Icon(
                                IconlyLight.camera,
                                size: 26,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        'الاسم الكامل',
                        style: FontStyle().textStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.black,
                        ),
                      ),
                      TextFormWidget(
                        icon: false,
                        emailController: nameController,
                        hintText: 'ادخل اسمك',
                        prefixIcon: const Icon(
                          IconlyLight.profile,
                        ),
                        validator: 'من فضلك ادخل الاسم',
                        obscureText: false,
                      ),
                      Spacer(),
                      Text(
                        'البريد الالكتروني',

                        style: FontStyle().textStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.black,
                        ),
                      ),
                      TextFormWidget(
                        enabled: false,

                        icon: false,
                        emailController: emailcontroller,
                        hintText: 'البريد الاكتروني',
                        prefixIcon: const Icon(
                          IconlyLight.message,
                        ),
                        validator: 'من فضلك ادخل البريد الاكتروني',
                        obscureText: false,
                      ),
                      Spacer(),
                      Text(
                        'تاريخ الميلاد ',
                        style: FontStyle().textStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.black,
                        ),
                      ),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          cursorColor: Colors.grey,
                          controller: birthdayController,
                          keyboardType: TextInputType.datetime,
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode()); // Hide keyboard
                            _selectDate(context);
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل تاريخ الميلاد';
                            }
                            return null;
                          },
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                              hintText: 'ادخل تاريخ ميلادك ',
                              labelStyle: const TextStyle(
                                  fontSize: 20, color: Colors.grey),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  // cubit.changePasswordVisibility();
                                },
                                icon: const Icon(
                                  IconlyLight.calendar,
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: InputBorder.none),
                        ),
                      ),
                      Spacer(),
                      Text(
                        ' رقم الهاتف',
                        style: FontStyle().textStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontColor: Colors.black,
                        ),
                      ),
                      TextFormWidget(
                        icon: false,
                        emailController: phoneController,
                        hintText: 'ادخل رقم هاتفك',
                        prefixIcon: const Icon(
                          IconlyLight.call,
                        ),
                        validator: 'من فضلك ادخل رقم هاتفك',
                        obscureText: false,
                      ),
                      Spacer(),
                      (state! is UpdateLoadingUserDataState)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : MyElevatedButton(
                              onPressed: () {
                                if (cubit.profileImage == null) {
                                  cubit.updateProfile(
                                    phone: phoneController.text,
                                    name: nameController.text,
                                    birthdate: birthdayController.text,
                                  ).then((value) async{
                                    await Future.delayed(const Duration(seconds: 2)).then((value) {
                                      Navigator.pop(context);
                                    });
                                  });
                                } else {
                                  cubit.updateProfileImage(
                                    phone: phoneController.text,
                                    name: nameController.text,
                                    birthdate: birthdayController.text,
                                  ).then((value) async{
                                    cubit.profileImage == null;
                                   await Future.delayed(const Duration(seconds: 2)).then((value) {
                                      Navigator.pop(context);
                                    });
                                  });
                                }
                              },
                              text: 'تـاكيد',
                            ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'تعديل ملفك الشخصي',
        style: GoogleFonts.tajawal(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
