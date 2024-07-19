
import 'package:flutter/material.dart';

import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/text_theme.dart';

class TAppTheme{
TAppTheme._();

static ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TTextTheme.lightTextTheme,
  elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme
);
static ThemeData darkTheme =  ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
  textTheme: TTextTheme.darkTextTheme,
  elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme
);

}