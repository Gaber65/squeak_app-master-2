import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:show_custom_snackbar/show_custom_snackbar.dart';

class SetPasswordScreen2 extends StatefulWidget {
   SetPasswordScreen2({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen2> createState() => _SetPasswordScreen2State();
}

class _SetPasswordScreen2State extends State<SetPasswordScreen2> {
   var passwordController1 = TextEditingController();

   var passwordController2 = TextEditingController();

  get selectedOption => null;


   void _showCustomDialog(BuildContext context) {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return Dialog(
          child:  Container(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset('assets/images/photo_2023-08-19_20-39-53.jpg'),
                  Text('تم اعادة تعيين كلمه المرور بنجاح'),
                  Container(
                    height:55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFF0D6EFD),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: MaterialButton(
                      onPressed: (){},
                      child: Text('استمرار',
                        style: GoogleFonts.tajawal(
                            color: Colors.white,
                            fontSize: 14
                        ),),
                    ),
                  )
                ],
              ),
            ),
          ),
         );
       },
     );
   }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: Text(' انشاء كلمه مرور جديدة',
                  style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      fontSize: 28

                  ),),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(child: Image.asset('assets/images/photo_2023-08-19_19-58-55.jpg')),
              const SizedBox(
                height: 40,
              ),
              Text('قم بأنشاء كلمة مرور جديدة',
              style: GoogleFonts.tajawal(
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.grey,
                controller: passwordController1,
                keyboardType: TextInputType.emailAddress,

                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك ادخل الباسورد';
                  }
                  return null;
                },
                keyboardAppearance: Brightness.dark,
                decoration: InputDecoration(
                    hintText: 'ادخل كلمه المرورالجديدة',
                    labelStyle:TextStyle(
                        fontSize: 20, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // cubit.changePasswordVisibility();
                      },
                      icon: Icon(
                        IconlyLight.show,
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: const Icon(
                      IconlyLight.lock,
                      color: Colors.grey,
                      size: 25,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: .9, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.grey,
                controller: passwordController2,
                keyboardType: TextInputType.emailAddress,

                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك ادخل الباسورد';
                  }
                  return null;
                },
                keyboardAppearance: Brightness.dark,
                decoration: InputDecoration(
                    hintText: 'تاكيد كلمه المرور',
                    labelStyle:TextStyle(
                        fontSize: 20, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // cubit.changePasswordVisibility();
                      },
                      icon: Icon(
                        IconlyLight.show,
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: const Icon(
                      IconlyLight.lock,
                      color: Colors.grey,
                      size: 25,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: .9, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: const Text('تذكرني'),
                leading: Radio(
                  value: 1,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    print("Button value: $value");

                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height:55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF1977F3),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: MaterialButton(onPressed: (){
                  _showCustomDialog(context);


                  // Widget okButton = Container(
                  //   height:55,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       color: Color(0xFF0D6EFD),
                  //       borderRadius: BorderRadius.circular(12)
                  //   ),
                  //   child: MaterialButton(
                  //     onPressed: (){},
                  //     child: Text('استمرار',
                  //     style: GoogleFonts.tajawal(
                  //       color: Colors.white,
                  //       fontSize: 14
                  //     ),),
                  //   ),
                  // );
                  //
                  // // set up the AlertDialog
                  // AlertDialog alert = AlertDialog(
                  //
                  //   content: Column(
                  //     children: [
                  //       Image.asset('assets/images/photo_2023-08-19_20-39-53.jpg'),
                  //       Text('تم اعادة تعيين كلمه المرور بنجاح')
                  //     ],
                  //   ),
                  //   actions: [
                  //     okButton,
                  //   ],
                  // );
                  //
                  // // show the dialog
                  // showDialog(
                  //
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return alert;
                  //   },
                  // );
                },

                  child:Text('متابعة',
                  style: GoogleFonts.tajawal(
                    color: Colors.white,
                    fontSize: 16
                  ),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

