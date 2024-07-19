import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/lib/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/presentation/screens/home_screen_page.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpFieldController _otpController = OtpFieldController();
  String otpPins = '';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? verificationId;

  @override
  void initState() {
    super.initState();
    sendOTP();
  }

  Future<void> sendOTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('user_credentials');
    log(jsonDecode(jsonString!)["userName"].split('@')[0]);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: jsonDecode(jsonString)["userName"].split('@')[0],
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await auth.signInWithCredential(credential);
          Navigator.pop(context, true);
        } catch (e) {
          log('Error: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification failed: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification failed: ${e.message}')),
        );
      },
      timeout: const Duration(seconds: 60),
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
        });
      },
      codeAutoRetrievalTimeout: (String verId) {
        setState(() {
          verificationId = verId;
        });
      },
    );
  }

  Future<void> _verifyOtp() async {
    if (_formKey.currentState!.validate() && verificationId != null) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!,
          smsCode: otpPins,
        );
        await auth.signInWithCredential(credential);
        Navigator.pop(context, true);
      } catch (e) {
        log('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP or verification ID')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP or verification ID')),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(TImages.otp),
              OTPTextField(
                controller: _otpController,
                length: 6,
                width: MediaQuery.of(context).size.width * 0.9,
                fieldWidth: 40,
                style: const TextStyle(fontSize: 17, color: Colors.blue),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                otpFieldStyle: OtpFieldStyle(borderColor: Colors.blue),
                onChanged: (c) {
                  setState(() {
                    otpPins = c;
                  });
                },
                onCompleted: (pin) async {
                  if (verificationId != null) {
                    try {
                      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                        verificationId: verificationId!,
                        smsCode: pin,
                      );
                      await auth.signInWithCredential(phoneAuthCredential);
                      log('Verification successful');
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String? jsonString = prefs.getString('user_credentials');
                      if (jsonString != null) {
                      Map<String, dynamic> jsonData = jsonDecode(jsonString);
                      jsonData["OTP"] = pin;
                      await prefs.setString('user_credentials', jsonEncode(jsonData));
                      }
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    } catch (e) {
                      log('Error: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
