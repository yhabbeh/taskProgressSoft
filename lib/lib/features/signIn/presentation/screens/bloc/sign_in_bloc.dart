import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../signUp/model/userInfoModel.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserCredential? userCredential;
  UserModel? userModel;

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        userCredential = await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        String jsonString = jsonEncode({
          "userName": event.email,
          "password": event.password,
        });

        try {
          DocumentSnapshot userDoc = await _firestore.collection('users').doc(
              userCredential?.user!.uid).get();

          if (userDoc.exists) {
            Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
            userModel = UserModel.fromJson(userData);
          }
        } catch (ee) {
          log(ee.toString());
        }

        await prefs.setString('user_credentials', jsonString);
        log('Success: ${userModel?.fullName}');
        emit(LoginSuccess());
      } on FirebaseAuthException catch (error) {
        String errorMessage = 'An unknown error occurred';
        if (error.code == 'user-not-found') {
          errorMessage = 'User not found';
        } else if (error.code == 'wrong-password') {
          errorMessage = 'Incorrect password';
        } else {
          errorMessage = error.message ?? 'An unknown error occurred';
        }
        emit(LoginFailure(errorMessage));
      }
    });
  }
}
