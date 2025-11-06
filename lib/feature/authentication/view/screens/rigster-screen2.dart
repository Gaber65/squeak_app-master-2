import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostakbal/core/const/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mostakbal/core/local/cache_helper.dart';
import 'package:mostakbal/feature/authentication/controller/auth_cubit.dart';
import 'package:mostakbal/feature/authentication/view/screens/accept-phone-screen.dart';
import 'package:mostakbal/feature/authentication/view/screens/set-password-screen.dart';
import 'package:mostakbal/feature/home_page/home_feeds/layout_screen.dart';

import '../../../../core/const/components/elevated_button.dart';
import '../../../../main.dart';

class RegisterScreen2 extends StatefulWidget {
  RegisterScreen2(
      {Key? key, required this.password, required this.emailcontroller})
      : super(key: key);
  String password;
  TextEditingController emailcontroller;
  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  var phoneController = TextEditingController();

  var emailcontroller = TextEditingController();

  var nameController = TextEditingController();

  var birthdayController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  get selectedOption => null;
  DateTime? _selectedDate;

  @override
  void initState() {
    emailcontroller = widget.emailcontroller;
    super.initState();
  }

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
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is CreateUserSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uid);
            uId = state.uid;
            print(uId);
            print(state.uid);
            RoutePage().navigateAndRemove(
              context,
              HomeLayoutScreen(),
            );
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'أكمل ملفك الشخصي',
                style: FontStyle().textStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontColor: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 70.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: const CircleAvatar(
                              radius: 65.0,
                              backgroundImage: NetworkImage(
                                  'https://img.freepik.com/premium-vector/arab-man-side-view-profile-guy-with-black-curly-hair-scarf-stands-sideways-looks-forward_206127-72.jpg?size=626&ext=jpg&ga=GA1.2.710542837.1687889462&semt=sph')),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            IconlyLight.camera,
                            size: 26,
                            color: Colors.white,
                          ))
                    ],
                  ),
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
                  Text(
                    'البريد الالكتروني',
                    style: FontStyle().textStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.black,
                    ),
                  ),
                  TextFormWidget(
                    icon: false,
                    emailController: emailcontroller,
                    hintText: 'البريد الاكتروني',
                    prefixIcon: const Icon(
                      IconlyLight.message,
                    ),
                    validator: 'من فضلك ادخل البريد الاكتروني',
                    obscureText: false,
                  ),
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
                          labelStyle:
                              const TextStyle(fontSize: 20, color: Colors.grey),
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
                  MyElevatedButton(
                    onPressed: () {
                      cubit.userRegister(
                        email: emailcontroller.text,
                        username: nameController.text,
                        phone: phoneController.text,
                        password: widget.password,
                        fullName: nameController.text,
                        birthdate: _selectedDate.toString(),
                      );
                    },
                    text: 'متابعة',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
