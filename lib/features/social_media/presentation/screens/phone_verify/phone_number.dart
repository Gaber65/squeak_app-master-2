import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squeak/core/resources/constants_manager.dart';
import 'package:squeak/core/widgets/components/styles.dart';
import 'package:squeak/core/widgets/elevated_button.dart';
import 'package:squeak/features/layout/layout.dart';
import 'package:squeak/features/social_media/presentation/controller/phone_cubit/phone_cubit.dart';

import '../../../../../core/network/end-points.dart';
import '../../../../../core/service/service_locator.dart';

class PhoneScreen extends StatefulWidget {
  PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  var text1 = TextEditingController();
  var text2 = TextEditingController();
  var text3 = TextEditingController();
  var text4 = TextEditingController();
  var text5 = TextEditingController();
  var text6 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int _countdownValue = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the countdown
    _startCountdown();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void _startCountdown() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        // Check if countdown is complete
        if (_countdownValue == 0) {
          timer.cancel();
          // Countdown completed, do something here
        } else {
          setState(() {
            _countdownValue--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PhoneCubit>(),
      child: BlocConsumer<PhoneCubit, PhoneState>(
        listener: (context, state) {
          if (state is VerifyPhoneDataSuccess) {
            FirebaseFirestore.instance.collection('users').doc(uId).update(
              {
                'isPhoneVerify': true,
              },
            ).then(
              (value) {
                PhoneCubit.get(context).getUserData();
                Navigator.pop(context);
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Verify Phone'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            controller: text1,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(1),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            controller: text2,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(1),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            controller: text3,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(1),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            controller: text4,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(1),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            controller: text5,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(1),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            onChanged: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            controller: text6,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(1),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          'Don\'t Receive any code ?',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        TextButton(
                          onPressed: () {
                            _startCountdown();
                            PhoneCubit.get(context).verifySendPhoneNumber(
                              phoneNumber: PhoneCubit.get(context)
                                  .socialDataUser!
                                  .phone!,
                              smsCode:
                                  '${text1.text}${text2.text}${text3.text}${text4.text}${text5.text}${text6.text}',
                            );
                          },
                          child: const Text(
                            'Send again',
                            style: TextStyle(fontSize: 12, color: appColorBtn),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '$_countdownValue',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Divider(),
                    MyElevatedButton(
                      onPressed: () {
                        PhoneCubit.get(context).verifySendPhoneNumber(
                          smsCode:
                              '${text1.text}${text2.text}${text3.text}${text4.text}${text5.text}${text6.text}',
                          phoneNumber:
                              PhoneCubit.get(context).socialDataUser!.phone!,
                        );
                      },
                      text: ('Confirm'),
                      colors: appColorBtn,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
