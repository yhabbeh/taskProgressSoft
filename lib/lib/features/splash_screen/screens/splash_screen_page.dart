import 'dart:async';
import 'dart:convert';
import 'package:e_commerce/lib/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants/text_strings_eng.dart';
import '../../home/presentation/screens/home_screen_page.dart';
import '../../signIn/presentation/screens/bloc/sign_in_bloc.dart';
import '../../signIn/presentation/screens/bloc/sign_in_event.dart';
import '../../signIn/presentation/screens/sign_in_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final LoginBloc authBloc = BlocProvider.of<LoginBloc>(context);
    Timer(const Duration(seconds: 2), () async {
      Map<String, dynamic> credentials = await getUserCredentials();
      if(credentials["OTP"] !=null) {
          authBloc.add(
          LoginButtonPressed(
            credentials["userName"]!,
            credentials["password"]!,
          ),
        );

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
               ));
      } else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>BlocProvider(
                create: (context) => LoginBloc(), // Provide your AuthBloc here
                child: LoginScreen(),
              ),
            ));
      }



    });
  }


  Future<Map<String, dynamic>> getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('user_credentials');
    if (jsonString != null) {
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return jsonData ;
    } else {
      return {};
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
             TImages.logo,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            const Spacer(),
            const Text(
                TTextsEnglish.txtCopyRight,
                style: TextStyle(fontSize: 10, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
