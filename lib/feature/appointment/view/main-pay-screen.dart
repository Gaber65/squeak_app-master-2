import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mostakbal/feature/appointment/view/screens/cridt-screen.dart';
import 'package:mostakbal/feature/home_page/home_feeds/layout_screen.dart';



class MainPayScreen extends StatefulWidget {
   MainPayScreen({Key? key}) : super(key: key);

  @override
  State<MainPayScreen> createState() => _MainPayScreenState();
}

class _MainPayScreenState extends State<MainPayScreen> {
   int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: Text('   الدفع',
                  style: GoogleFonts.arsenal(
                      fontWeight: FontWeight.bold,
                      fontSize: 25

                  ),),
              ),

              const SizedBox(
                height: 40,
              ),


              Text(' طريقة الدفع',
                style: GoogleFonts.arsenal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100
                ),
                child: RadioListTile(


                  controlAffinity: ListTileControlAffinity.trailing,
                  title:Row(
                    children: [
                      Container(
                        height: 44,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Logo(Logos.mastercard,size: 40)),
                      Text('كريدت كارد')
                    ],
                  ),
                  value: 0,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100
                ),
                child: RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,

                  title:Row(
                    children: [
                      Container(
                          height: 44,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Logo(Logos.paypal,size: 40)),
                      Text(' باي بال')
                    ],
                  ),
                  value: 1,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100
                ),
                child: RadioListTile(

                  controlAffinity: ListTileControlAffinity.trailing,
                  title:Row(
                    children: [
                      Container(
                          height: 44,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Logo(Logos.apple_pay,size: 40)),
                      Text(' ابل باي')
                    ],
                  ),

                  value: 2,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height:60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF0D6EFD),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: MaterialButton(onPressed: (){
                  if(selectedOption==1){

                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => UsePaypal(
                              sandboxMode: true,
                              clientId:
                              "AUEI_eeQiPbamVmVORv-deke8oEoKpcsBBgV_w1yatxRGIOGmqjDiWWHqpXbSX69WUPrmuqIQeH_Ej4I",
                              secretKey:
                              'EGRHtBJIjmKMOHE9S8DYxpZsfm0M52EE2vS6HhrJQaOnYaewB3Ct9iqzWzTOFeXwneRodc72tnllQPi5',
                              returnURL: "https://samplesite.com/return",
                              cancelURL: "https://samplesite.com/cancel",
                              transactions: const [
                                {
                                  "amount": {
                                    "total": '10.12',
                                    "currency": "USD",
                                    "details": {
                                      "subtotal": '10.12',
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description":
                                  "The payment transaction description.",
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": [
                                      {
                                        "name": "A demo product",
                                        "quantity": 1,
                                        "price": '10.12',
                                        "currency": "USD"
                                      }
                                    ],

                                    // shipping address is not required though
                                    "shipping_address": {
                                      "recipient_name": "Jane Foster",
                                      "line1": "Travis County",
                                      "line2": "",
                                      "city": "Austin",
                                      "country_code": "US",
                                      "postal_code": "73301",
                                      "phone": "+00000000",
                                      "state": "Texas"
                                    },
                                  }
                                }
                              ],
                              note: "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                print("onSuccess: $params");
                                // showSnackBar(context: (context), text: 'Payment Sucesss', color: Colors.green);

                                print("succccccccccccccccccccccccccccccccccccccccccccccccccccccccccessssssssssssssssssssssssssss");
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return HomeLayoutScreen();
                                }));
                              },
                              onError: (error) {
                                print("onError: $error");
                              },
                              onCancel: (params) {
                                print('cancelled: $params');
                              }),
                        ));
                  }
                  if(selectedOption==0){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CridtScreen();

                    }));
                  }




                },
                  child: Text('متابعة',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
