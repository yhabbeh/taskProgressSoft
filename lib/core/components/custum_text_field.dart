import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final VoidCallback? function;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? isObscureText;
  final String? prefixText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.function,
    this.validator,
    required this.controller,
    this.isObscureText,
    this.prefixText,
    this.suffixIcon,
    required this.labelText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText ?? false,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.background,
          errorStyle: const TextStyle(fontSize: 12) ,
          hintStyle: const TextStyle(fontSize: 12),
          labelStyle: const TextStyle(fontSize: 12),
          filled: true,
          isDense: true,
          hintText: hintText,
          labelText: labelText,
          prefixText: prefixText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:  BorderSide(color: Theme.of(context).colorScheme.onBackground,),),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground,),),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground,),),

        ),
        onChanged: function != null ? (_) => function!() : null,
      ),
    );
  }
}
