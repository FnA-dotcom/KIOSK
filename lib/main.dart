import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rovermd/splash.dart';

//Use this URL Below TO give the temporary access to the HTTP Request
//https://cors-anywhere.herokuapp.com/corsdemo

//The problem is in server side that it does not allow request to pass through
//Cross-Origin Resource Sharing (CORS).
// CORS (Cross-Origin Resource Sharing) error. This occurs
// when the app attempts to make a request to a different domain t
// han the one that served the app. Chrome is more strict in enforcing
// CORS policies than Android, which could explain why the issue only
// occurs in Chrome.


void main() {
  runApp(const MyApp());
  configLoading();
}


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Menu',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red,
      ),
      home: Splash(),
      builder: EasyLoading.init(),
    );
  }
}
