

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mostakbal/feature/authentication/view/screens/set-password2.dart';

class VeificationScreen extends StatelessWidget {
   VeificationScreen({Key? key}) : super(key: key);
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   TextEditingController _codeController1 = TextEditingController();
   TextEditingController _codeController2 = TextEditingController();
   TextEditingController _codeController3 = TextEditingController();
   TextEditingController _codeController4 = TextEditingController();
   TextEditingController _codeController5 = TextEditingController();

   void _submitCode() {
     // Handle verification code here
     String verificationCode =
         _codeController1.text +
             _codeController2.text +
             _codeController3.text +
             _codeController4.text +
             _codeController5.text;
     // You can validate the code and perform actions accordingly
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text('تاكيد رقم الهاتف',style: GoogleFonts.arsenal(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Text('لقد قمنا بارسال رمز تاكيد لهذا الرقم ',style: GoogleFonts.arsenal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                Text(' 0122194430',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  color: Colors.orange

                ),),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCodeTextField(_codeController1),
                buildCodeTextField(_codeController2),
                buildCodeTextField(_codeController3),
                buildCodeTextField(_codeController4),
                buildCodeTextField(_codeController5),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width/4,
              height: MediaQuery.of(context).size.height/18,
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('0:22'),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(IconlyLight.time_circle)
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('لم يصلك كود؟',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.grey.shade400
                  ),),
                TextButton(onPressed: (){}, child: Text('اعاده ارسال',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.grey.shade800
                  ),)),



              ],
            ),
            const SizedBox(
              height: 40,
            ),

            Container(
              height:50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color:Color(0xFF0D6EFD),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: MaterialButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){

                  return SetPasswordScreen2();
                }));
              },
                child: Text('متابعة',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),),
            ),

          ],
        ),
      ),
    );
  }
}
Widget buildCodeTextField(TextEditingController controller) {
  return Container(
    width: 50,
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 1,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        counterText: '',

        contentPadding: EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: Colors.grey),
        ),
      ),
      onChanged: (value) {

      },
    ),
  );
}
