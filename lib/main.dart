import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/HomeScreen/home_screen.dart';
import 'Screens/LoginScreen/login_screen.dart';
import 'Screens/LoginScreen/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "المدير الاداري",
    home: email == null ? LoginScreen() : HomeScreen(),
    theme: ThemeData(
      fontFamily: 'ExpoArabic-Book',
    ),

    // عربي
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('ar'), // English
    ],
    routes: {
      LoginScreen.id: (cotext) => LoginScreen(),
      SignupScreen.id: (cotext) => SignupScreen(),
    },
  ));
}

