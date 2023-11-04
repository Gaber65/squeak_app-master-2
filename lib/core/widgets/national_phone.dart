import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'components/styles.dart';

class IntlPhoneNumber extends StatefulWidget {
  IntlPhoneNumber({super.key, required this.controller});
  TextEditingController controller;

  @override
  _IntlPhoneNumberState createState() => _IntlPhoneNumberState();
}

class _IntlPhoneNumberState extends State<IntlPhoneNumber> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      textStyle: TextStyle(fontSize: 15),
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
      initialValue: number,
      textFieldController: widget.controller,
      formatInput: true,
      inputBorder: InputBorder.none,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
      inputDecoration: const InputDecoration(
        fillColor: Colors.white,
        suffixIcon: Icon(IconlyLight.call),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: appColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: appColor,
          ),
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }
}
