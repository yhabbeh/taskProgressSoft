import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../signIn/presentation/screens/bloc/sign_in_bloc.dart';
import '../../../../signIn/presentation/screens/bloc/sign_in_state.dart';
import '../../../../signIn/presentation/screens/sign_in_page.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.logout),onPressed: ()async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove("user_credentials");
            await auth.signOut();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    LoginScreen()));
          },),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Data Available'),
                  // Text(BlocProvider.of<LoginBloc>(context).userCredential?.user?.email.toString()??'aaa'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
