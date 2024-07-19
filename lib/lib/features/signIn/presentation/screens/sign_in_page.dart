import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/lib/features/signIn/presentation/screens/widgets/login_box_widget.dart';
import 'package:e_commerce/lib/utils/constants/text_strings_eng.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../OTP/screens/OTP_page.dart';
import '../../../home/presentation/screens/home_screen_page.dart';
import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_in_state.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginSuccess) {
              Navigator.of(context).push (
                  MaterialPageRoute(builder: (context) => OtpScreen(),));
            } else if (state is LoginFailure) {

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(TTextsEnglish.txtFailedLogin,style:TextStyle( fontSize: 12)),),
              );
          } ; },
          child: LoginBoxWidget(
              formKey: _formKey,
              usernameController: _usernameController,
              passwordController: _passwordController),
        ),
      ),
    );
  }
}
