import 'package:flutter/material.dart';
import 'package:stopwatch/screens/WelcomeScreen.dart';
import 'package:stopwatch/screens/InputPage.dart';
import 'package:stopwatch/screens/LoginPage.dart';
import 'package:stopwatch/screens/Event.dart';
import 'package:stopwatch/screens/register/RegisterPage1.dart';
import 'package:stopwatch/screens/register/RegisterPage2.dart';
import 'package:stopwatch/screens/register/RegisterPage3.dart';
import 'package:stopwatch/screens/ForgotPassword.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomePage(),
        'login_screen': (context) => LoginPage(),
        'registration_screen': (context) => RegistrationScreen(),
        'registration_screen2': (context) => RegistrationScreen2(),
        'registration_screen3': (context) => RegistrationScreen3(),
        'input_screen': (context) => InputPage(),
        'event_screen': (context) => EventPage(),
        'forgotpass_screen': (context) => ForgotPassword(),
      },
    );
  }
}
