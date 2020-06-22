import 'package:flutter/material.dart';
import 'package:stopwatch/components/bottomnavbar.dart';
import 'package:stopwatch/screens/charity/charityEvent.dart';
import 'package:stopwatch/screens/charity/createEvent/createEvent1.dart';
import 'package:stopwatch/screens/charity/eventList.dart';
import 'package:stopwatch/screens/charity/upcomingEvents/upcomingEvents1.dart';
import 'package:stopwatch/screens/charity/upcomingEvents/upcomingEvents2.dart';
import 'package:stopwatch/screens/morepages/connect.dart';
import 'package:stopwatch/screens/morepages/mission.dart';
import 'package:stopwatch/screens/profile/editProfilePage.dart';
import 'package:stopwatch/screens/startup/WelcomeScreen.dart';
import 'package:stopwatch/screens/startup/LoginPage.dart';
import 'package:stopwatch/screens/startup/register/RegisterPage1.dart';
import 'package:stopwatch/screens/startup/ForgotPassword.dart';
import 'package:stopwatch/screens/morepages/MorePage.dart';

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
        'forgotpass_screen': (context) => ForgotPassword(),
        'nav_screen': (context) => BottomNav(),
        'more_page': (context) => MainMore(),
        'mission_page': (context) => MissionPage(),
        'connect_page': (context) => ConnectPage(),
        'charity_event': (context) => CharityEventPage(),
        'create_event1': (context) => CreateEvent1(),
        'charityevent_list': (context) => CharityEventList(),
        'upcoming_event1': (context) => UpcomingEvent1(),
        'upcoming_event2': (context) => UpcomingEvent2(),
        'edit_profile': (context) => EditProfile(),
      },
    );
  }
}
