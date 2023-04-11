import 'package:flutter/material.dart';
import 'package:rovermd/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    navigateToHome();
  }

  navigateToHome() async{
    //will set this for login purpose
    //Now after 2 seconds of splash screen navigating to Home Screen
    //Wait 2 seconds can be changed according to the requirement.
    await Future.delayed(const Duration(milliseconds: 5000), (){});
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenImage(),
    );
  }

}

class SplashScreenImage extends StatelessWidget {
  const SplashScreenImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/logo_black_1.png');
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: assetImage,
        ),
      ),
    );
  }
}


