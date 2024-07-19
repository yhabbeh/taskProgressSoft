import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/lib/features/signUp/presentation/screens/widgets/phoneNumber_field_widget.dart';
import 'package:e_commerce/lib/utils/constants/images.dart';
import 'package:e_commerce/lib/utils/constants/text_strings_eng.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/components/custom_dropdown_field.dart';
import 'package:e_commerce/core/components/custum_text_field.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../../utils/validators/validation.dart';
import '../../../home/presentation/screens/home_screen_page.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _gender;
  int? selectedAge;
  final _formKey = GlobalKey<FormState>();

  Future<void> _register({required String username, required String password}) async {
    if (_formKey.currentState?.validate() ?? false)
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': _nameController.text,
        'mobileNumber': phoneNumberController.text,
        'age': _ageController.text,
        'gender': _gender,
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The email address is already in use by another account.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: ${e.message?.replaceAll('email', 'Phone')}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              children: [
                Image.asset(TImages.logo),
                CustomTextField(
                  hintText: 'Full Name',
                  labelText: 'Full Name',
                  controller: _nameController,
                  validator:  (value) => TValidator.validateField(value),
                ),
                PhoneNumber(phoneNumberController: phoneNumberController, ),
                CustomDropDownField(
                  title: 'Age',
                  hint: 'Select Age',
                  items: List.generate(53, (index) => index + 13).map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                CustomDropDownField(
                  title: TTextsEnglish.txtGender,
                  hint: TTextsEnglish.txtSelectGender,
                  items: [TTextsEnglish.txtMale, TTextsEnglish.txtFemale].map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                CustomTextField(
                  hintText: TTextsEnglish.txtPassword,
                  labelText: TTextsEnglish.txtPassword,
                  controller: _passwordController,
                  isObscureText: true,
                  validator: (value) => TValidator.validatePassword(value),
                ),
                CustomTextField(
                  hintText: TTextsEnglish.txtConfirm,
                  labelText:   TTextsEnglish.txtConfirm,
                  controller: _confirmPasswordController,
                  isObscureText: true,
                  validator: (value) => TValidator.validateConfirmPassword(value, _passwordController.text),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.28,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _register(
                      password: _passwordController.text,
                      username: '${phoneNumberController.text}@gmail.com',
                    ),
                    child: const Text(TTextsEnglish.txtRegister),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
