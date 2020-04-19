import 'package:flutter/material.dart';
import 'package:stopwatch/screens/WelcomeScreen.dart';
import 'package:stopwatch/screens/InputPage.dart';
import 'package:stopwatch/screens/LoginPage.dart';
import 'package:stopwatch/screens/Event.dart';
import 'package:stopwatch/screens/RegisterPage.dart';
import 'package:stopwatch/screens/StopWatch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF050505),
      ),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomePage(),
        'login_screen': (context) => LoginPage(),
        'registration_screen': (context) => RegistrationScreen(),
        'input_screen': (context) => InputPage(),
        'event_screen': (context) => EventPage(),
      },
    );
  }
}
