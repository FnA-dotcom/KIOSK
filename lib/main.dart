import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rovermd/splash.dart';

//https://cors-anywhere.herokuapp.com/corsdemo
//To get the responses from the API hit above URL and then press
//Request temporary access to the demo server to give the access to
//run the project any other platform like chrome or any
// other device.

//The problem is in server side configration that does not
// ALLOW Cross-Origin Resource Sharing (CORS) to access
// any api data from any other platform except mobile devices
// not even emulators So I added this proxy but this is a
//temprary solution only.

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
