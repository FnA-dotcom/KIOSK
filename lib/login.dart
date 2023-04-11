import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rovermd/personal_info_reg1.dart';
import 'package:rovermd/utility_methods.dart';


UtilityMethods utilityMethods = new UtilityMethods();
bool _isHide = true;
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;

  TextEditingController userIdController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(microseconds: 600));
    Timer(Duration(milliseconds: 1000), () =>  _animationController.forward());
    super.initState();
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the App?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () => SystemNavigator.pop(),
            //return true when click on "Yes"
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("LOGIN",
            style: TextStyle(
                color: Colors.black
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFFD0F97E),
                  Color(0xFFF0CD80),
                  Color(0xFFF9BF80),
                ],
              ),
            ),
          ),

        ),
        body: SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 1), end: Offset(.0, .0))
              .animate(_animationController),
          child: Container(
            // alignment: Alignment.center,
            width: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width - 600 : MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Stack(
              // alignment: Alignment.center,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                    utilityMethods.getLogo('images/logo_black.png', 4.0),
                    Padding(padding: EdgeInsets.only(top: 30.0)),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          controller: userIdController,
                          decoration: InputDecoration(
                              labelText: 'User ID',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(
                                      color: Colors.grey, width: 1.0))
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          obscureText: _isHide,
                          controller: pwdController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0),
                              suffix: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(
                                  _isHide ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(
                                      color: Colors.grey, width: 1.0))),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 5.0),
                      child: Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xffEBC248),
                                  Color(0xffEBA223),
                                ]),
                          ),
                          child: ElevatedButton(
                              onPressed: () async{
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => PersonalInfoRegister()), (Route<dynamic> route) => false);
                                FocusScope.of(context).unfocus();
                                String userId = userIdController.text;//EncryptDecrypt.encryptAES(userIdController.text);
                                String pwd = pwdController.text;//EncryptDecrypt.encryptAES(pwdController.text);
                                // print(userId);
                                // print(pwd);
                                // if(userId == "" || pwd == ""){
                                //   EasyLoading.showError("Enter user details to login");
                                //   return;
                                // }else {
                                //   // utilityMethods.login(
                                //   //     userId,
                                //   //     pwd, context);
                                //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => PersonalInfoRegister()), (Route<dynamic> route) => false);
                                // }
                              },
                              child: Text('SIGN IN',
                                  style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  )))),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Text("Designed and Maintained by RoverMD",
                      textAlign: TextAlign.center,)
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHide = !_isHide;
    });
  }
}
