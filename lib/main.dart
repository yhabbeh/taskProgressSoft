import 'package:e_commerce/lib/features/signIn/presentation/screens/bloc/sign_in_bloc.dart';
import 'package:e_commerce/lib/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'lib/features/splash_screen/screens/splash_screen_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: SplashScreen(),
      ),
    );
  }
}
