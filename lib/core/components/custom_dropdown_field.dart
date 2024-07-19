

import 'dart:developer';

import 'package:e_commerce/lib/utils/validators/validation.dart';
import 'package:flutter/material.dart';

class CustomDropDownField extends StatelessWidget {
   dynamic value   ;
  final String title , hint ;
  final List<DropdownMenuItem<dynamic>> items;

  CustomDropDownField({super.key, required this.title, required this.hint, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      child: DropdownButtonFormField<dynamic>(
        hint: Text(hint),
        value: value,
        alignment: Alignment.centerLeft,
        validator:  (value) => TValidator.validateField(value.toString()),
        menuMaxHeight: 200,
        isDense: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.background,
          hintText:  title,
          labelText: title,
          hintStyle:const TextStyle(fontSize: 12),
          labelStyle: const TextStyle(fontSize: 12),
          errorStyle: const TextStyle(fontSize: 12) ,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:  BorderSide(color: Theme.of(context).colorScheme.onBackground,),),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground,),),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground,),),
        ),
        onChanged: (dynamic newValue) {
          value =newValue.toString();
        },
        items: items ,

      ),

    );
  }
}
