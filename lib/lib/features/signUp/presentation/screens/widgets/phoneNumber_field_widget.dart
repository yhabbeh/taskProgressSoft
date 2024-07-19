
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../utils/validators/validation.dart';

class PhoneNumber extends StatelessWidget {

    const PhoneNumber({
    super.key, required this.phoneNumberController,
  });
  final TextEditingController phoneNumberController  ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.02),
      child: IntlPhoneField(
        validator:  (value) => TValidator.validatePhoneNumber(value?.number),
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: 12) ,
          counterStyle: const TextStyle(fontSize: 12) ,
          hintStyle: const TextStyle(fontSize: 12) ,
          labelStyle:  const TextStyle(fontSize: 14),
          labelText: 'Phone Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        initialCountryCode: 'JO',
        onChanged: (phone) {
          phoneNumberController.text = phone.completeNumber;
        },
      ),
    );
  }
}