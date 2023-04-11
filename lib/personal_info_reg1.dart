
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rovermd/Model/ethnicity_race_model.dart';
import 'package:rovermd/insurance_marketing_reg2.dart';
import 'package:rovermd/login.dart';
import 'package:rovermd/utility_methods.dart';

import 'Model/gender_model.dart';

import 'package:virtual_keyboard_2/virtual_keyboard_2.dart';


UtilityMethods utilityMethods = new UtilityMethods();


class PersonalInfoRegister extends StatefulWidget {
  const PersonalInfoRegister({Key? key}) : super(key: key);

  @override
  State<PersonalInfoRegister> createState() => _PersonalInfoRegisterState();
}

class _PersonalInfoRegisterState extends State<PersonalInfoRegister> {

  List<Gender>? genders;
  Gender? selectedGender;

  List<Ethnicity>? ethnicities;
  List<Race>? race;

  TextEditingController _keyboardControllerText = TextEditingController();
  bool keyBoardVisilityCheck = true;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleInitialController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController streetAddController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController ethController = TextEditingController();
  String ethId = "";
  TextEditingController raceController = TextEditingController();
  TextEditingController specifyReasonController = TextEditingController();
  TextEditingController reasonVsitController = TextEditingController();

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();
  final FocusNode sexFocusNode = FocusNode();
  final FocusNode phoneNoFocusNode = FocusNode();
  final FocusNode reasonVsitFocusNode = FocusNode();
  final FocusNode specifyReasonFocusNode = FocusNode();

  String sexType = "Male";

  String reasonVisitType = "COVID Testing";

  var phoneNoMaskFormatter = new MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  // @override
  // void dispose() {
  //   firstNameFocusNode.dispose();
  // }

  @override
  void initState() {
    utilityMethods.genderController().then((genders) {
      setState(() {
        this.genders = genders;
      });
    });

    utilityMethods.ethnicityController().then((ethnicity) {
      setState(() {
        this.ethnicities = ethnicity;
      });
    });

    utilityMethods.raceController().then((race) {
      setState(() {
        this.race = race;
      });
    });


  }

  // void virtualKeyboard(TextEditingController _controllerText){
  //    VirtualKeyboard(
  //       height: 300,
  //       textColor: Colors.white,
  //       type: VirtualKeyboardType.Alphanumeric,
  //       textController: _controllerText
  //   );
  // }

  showSexTypeDialog(BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select a gender'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return SingleChildScrollView(
                  child: ListBody(
                    children: genders!.map((Gender gender){
                      return RadioListTile(
                        title: Text(gender.gender),
                        value: gender,
                        groupValue: selectedGender,
                        onChanged: (Gender? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(selectedGender);
                  sexController.text = selectedGender!.gender;
                },
              ),
            ],

          );
        }).then((value) {
      // Update the state after the dialog is dismissed
      setState(() {});
    });
  }

  void _showEthDialog(BuildContext context){
    Map<int?, bool> _checked = {};
    List<Ethnicity> _filteredEthnicities = ethnicities!;
    Map<int, int> _ethnicityMap = Map.fromIterable(ethnicities!,
      key: (ethnicity) => ethnicities!.indexOf(ethnicity),
      value: (ethnicity) => ethnicities!.indexOf(ethnicity),
    );

    EasyLoading.dismiss();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Ethnicity'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Container(
                width: double.maxFinite,
                child:Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Ethnicities...',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          // Filter the ethnicities list based on the search query
                          _filteredEthnicities = ethnicities!
                              .where((ethnicity) => ethnicity.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                              .toList();
                          _ethnicityMap = Map.fromIterable(_filteredEthnicities,
                            key: (ethnicity) => _filteredEthnicities.indexOf(ethnicity),
                            value: (ethnicity) => ethnicities!.indexOf(ethnicity),
                          );
                        });
                      },
                    ),
                    Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredEthnicities.length,
                          itemBuilder: (BuildContext context, int index) {
                            final ethnicity = _filteredEthnicities[index];
                            return CheckboxListTile(
                              title: Text(ethnicity.name),
                              value: _checked.containsKey(_ethnicityMap[index]) ? _checked[_ethnicityMap[index]] : false,
                              onChanged: (bool? value) {
                                setState(() {
                                  _checked[_ethnicityMap[index]] = value!;
                                });
                              },
                            );
                          },
                        )
                    )
                  ],
                ),
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                List<Ethnicity> selectedEthnicities = [];
                List<int> selectedEthIDRespectively = [];
                _checked.forEach((index, isChecked) {
                  if (isChecked) {
                    selectedEthnicities.add(ethnicities![index!]);
                    selectedEthIDRespectively.add(ethnicities![index!].id);
                  }
                });
                print("selectedEthnicities--${selectedEthnicities.toString()}");
                print("selectedEthIDRespectively--${selectedEthIDRespectively.toString()}");
                ethController.text = selectedEthnicities.toString().substring(1, selectedEthnicities.toString().length - 1);
                ethId = selectedEthIDRespectively.toString().substring(1, selectedEthIDRespectively.toString().length - 1);
                // ethController.text = selectedEthnicities.toString();
                // Do something with the selected ethnicities
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _showRaceDialog(BuildContext context){
    Map<int?, bool> _checked = {};
    List<Race> _filteredRace = race!;
    Map<int, int> _raceMap = Map.fromIterable(race!,
      key: (racee) => race!.indexOf(racee),
      value: (racee) => race!.indexOf(racee),
    );

    EasyLoading.dismiss();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Race'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Container(
                width: double.maxFinite,
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Race...',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          // Filter the ethnicities list based on the search query
                          _filteredRace = race!
                              .where((racee) => racee.conceptName
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                              .toList();
                          _raceMap = Map.fromIterable(_filteredRace,
                            key: (racee) => _filteredRace.indexOf(racee),
                            value: (racee) => race!.indexOf(racee),
                          );
                        });
                      },
                    ),

                    Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredRace.length,
                          itemBuilder: (BuildContext context, int index) {
                            final racee = _filteredRace[index];
                            return CheckboxListTile(
                              title: Text(racee.conceptName),
                              value: _checked.containsKey(_raceMap[index]) ? _checked[_raceMap[index]] : false,
                              onChanged: (bool? value) {
                                setState(() {
                                  _checked[_raceMap[index]] = value!;
                                });
                              },
                            );
                          },
                        )
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                List<Race> selectedRace = [];
                _checked.forEach((index, isChecked) {
                  if (isChecked) {
                    selectedRace.add(race![index!]);
                  }
                });
                print("selectedRace--${selectedRace.toString()}");
                raceController.text = selectedRace.toString().substring(1, selectedRace.toString().length - 1);
                // ethController.text = selectedEthnicities.toString();
                // Do something with the selected ethnicities
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  showReasonVisitDialog(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFC0C0C0),
          scrollable: true,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child:Radio(
                            value: "COVID Testing",
                            groupValue: reasonVisitType,
                            onChanged: (value){
                              setState(() {
                                reasonVisitType = value.toString();//selected value
                              });
                              // print(value);

                            }
                        ),
                      ),
                      Text("COVID Testing"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child:Radio(
                            value: "Emergency",
                            groupValue: reasonVisitType,
                            onChanged: (value){
                              print(value);
                              setState(() {
                                reasonVisitType = value.toString();//selected value
                              });
                            }
                        ),
                      ),
                      Text("Emergency"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child:Radio(
                            value: "Sport Physical",
                            groupValue: reasonVisitType,
                            onChanged: (value){
                              print(value);
                              setState(() {
                                reasonVisitType = value.toString();//selected value
                              });
                            }
                        ),
                      ),
                      Text("Sport Physical"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child:Radio(
                            value: "Occmed",
                            groupValue: reasonVisitType,
                            onChanged: (value){
                              print(value);
                              setState(() {
                                reasonVisitType = value.toString();//selected value
                              });
                            }
                        ),
                      ),
                      Text("Occmed"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child:Radio(
                            value: "BBH",
                            groupValue: reasonVisitType,
                            onChanged: (value){
                              print(value);
                              setState(() {
                                reasonVisitType = value.toString();//selected value
                              });
                            }
                        ),
                      ),
                      Text("BBH"),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: StadiumBorder(),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffEBC248),
                              Color(0xffEBA223),
                            ]),
                      ),
                      child: ElevatedButton(
                        onPressed: (){
                          print("reasonVisitType--$reasonVisitType");
                          Navigator.pop(context);
                          //EasyLoading.show(status: 'Updating Map...');
                          setState(() {
                            reasonVsitController.text = reasonVisitType;
                          });
                        },
                        child: Text("Set",
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            textStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)
                        ),
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: StadiumBorder(),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffEBC248),
                              Color(0xffEBA223),
                            ]),
                      ),
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Close",
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            textStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)
                        ),
                      ),
                    )
                )
              ],
            )


          ],
        );
      },
    );
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


  void showKeyboard() {
    SystemChannels.textInput.invokeMethod('firstNameFocusNode.show');
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: showExitPopup,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text("PERSONAL INFO",
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
            actions: [
              //logout Button Button here in the right cornor
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
                    // FocusScope.of(context).unfocus();
                    //Logout button wto get this done
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
                  },
                  child: utilityMethods.getLogo("images/logout_button.png", 1.0),
                  style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ))))),
            ],
          ),
          bottomNavigationBar:
          BottomAppBar(
            color: Color(0xFFC0C0C0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Powered By RoverMD",
                      style: TextStyle(
                        // color: Color(0xFFC0C0C0),
                          fontSize: 16.0
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 5.0, right: 10.0),
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
                              String firstName = firstNameController.text;
                              String middleName = middleInitialController.text;
                              String lastName = lastNameController.text;
                              String dob = dobController.text;
                              String sex = sexController.text;
                              String phoneNo = phoneNoController.text;
                              String streetAdd = streetAddController.text;
                              String city = cityController.text;
                              String state = stateController.text;
                              String zipCode = zipCodeController.text;
                              String ethList = ethController.text;
                              String ethIdList = ethId;
                              String raceList = raceController.text;
                              String reasonVisit = reasonVsitController.text;
                              String specifyReason = specifyReasonController.text;
                              if(firstName == ""){
                                EasyLoading.showError("Enter first name");
                                firstNameFocusNode.requestFocus();
                                return;
                              }
                              if(lastName == ""){
                                EasyLoading.showError("Enter last name");
                                lastNameFocusNode.requestFocus();
                                return;
                              }
                              if(dob == ""){
                                EasyLoading.showError("Enter date of birth");
                                dobFocusNode.requestFocus();
                                return;
                              }
                              if(sex == ""){
                                EasyLoading.showError("Enter sex/gender");
                                sexFocusNode.requestFocus();
                                return;
                              }
                              if(phoneNo == ""){
                                EasyLoading.showError("Enter phone no.");
                                phoneNoFocusNode.requestFocus();
                                return;
                              }
                              if(reasonVisit == ""){
                                EasyLoading.showError("Enter reason for visit");
                                reasonVsitFocusNode.requestFocus();
                                return;
                              }
                              if(specifyReason == ""){
                                EasyLoading.showError("Please specify reason for visit");
                                specifyReasonFocusNode.requestFocus();
                                return;
                              }
                              //Store this data in shared pref and then when
                              //sending this get this all from shared pref and send the data

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => InsuranceAndMarketingRegister(firstName : firstName,middleName : middleName,lastName : lastName,dob : dob,sex : sex,phoneNo : phoneNo,streetAdd : streetAdd,city : city,state : state,zipCode : zipCode,ethList : ethList, ethIdList: ethIdList ,raceList : raceList,reasonVisit : reasonVisit,specifyReason : specifyReason )),
                              );

                            },
                            child: Text("NEXT"),
                            style: ElevatedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                ))))),
              ],
            ),
          ),
          body: Container(
            // alignment: Alignment.center,
            width: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width - 600 : MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF14468B),
                    Color(0xFF0F2E5A),
                    Color(0xff0A1B34),
                  ],
                )
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: firstNameController,
                            focusNode: firstNameFocusNode,
                            onTap: (){
                              setState(() {
                                _keyboardControllerText = firstNameController;
                              });
                            },
                            decoration: InputDecoration(
                                labelText: 'First Name',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.red, width: 2.0))
                            ),

                          )
                      ),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: middleInitialController,
                            decoration: InputDecoration(
                                labelText: 'Middle Initial',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.grey, width: 1.0))
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: lastNameController,
                            focusNode: lastNameFocusNode,
                            decoration: InputDecoration(
                                labelText: 'Last Name',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.red, width: 2.0))
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: dobController,
                            focusNode: dobFocusNode,
                            decoration: InputDecoration(
                                labelText: 'Date of Birth',
                                prefixIcon: Icon(Icons.calendar_month),
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.red, width: 2.0))
                            ),
                            onTap: () async{
                              String formattedDob = "";
                              DateTime? dob = await showDatePicker(
                                  context: context, //context of current state
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));
                              if(dob != null){
                                formattedDob = DateFormat('MM/dd/yyyy').format(dob);
                              }
                              dobController.text = formattedDob;
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: sexController,
                            focusNode: sexFocusNode,
                            decoration: InputDecoration(
                                labelText: 'Sex',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.red, width: 2.0))
                            ),
                            onTap: (){
                              showSexTypeDialog(context);
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: phoneNoController,
                            focusNode: phoneNoFocusNode,
                            keyboardType: TextInputType.phone,
                            autocorrect: false,
                            inputFormatters: [
                              phoneNoMaskFormatter
                            ],
                            decoration: InputDecoration(
                                labelText: 'Phone',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.red, width: 2.0))
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: streetAddController,
                            decoration: InputDecoration(
                                labelText: 'Street Address',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.grey, width: 1.0))
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: cityController,
                            decoration: InputDecoration(
                                labelText: 'City',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.grey, width: 1.0))
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: stateController,
                            decoration: InputDecoration(
                                labelText: 'State',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.grey, width: 1.0))
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: zipCodeController,
                            decoration: InputDecoration(
                                labelText: 'Zip Code',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.grey, width: 1.0))
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            color: Colors.white,
                            child: TextFormField(
                              readOnly: true,
                              controller: ethController,
                              decoration: InputDecoration(
                                  labelText: 'Ethnicity',
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(
                                          color: Colors.grey, width: 1.0))
                              ),
                              onTap: (){
                                EasyLoading.show(status: 'loading...');
                                _showEthDialog(context);
                              },
                            ) ,
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            color: Colors.white,
                            child: TextFormField(
                              readOnly: true,
                              controller: raceController,
                              decoration: InputDecoration(
                                  labelText: 'Race',
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(
                                          color: Colors.grey, width: 1.0))
                              ),
                              onTap: (){
                                EasyLoading.show(status: 'loading...');
                                _showRaceDialog(context);
                              },
                            )
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: reasonVsitController,
                            focusNode: reasonVsitFocusNode,
                            decoration: InputDecoration(
                                labelText: 'Reason for Visit',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.red, width: 2.0))
                            ),
                            onTap: (){
                              showReasonVisitDialog(context);
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: specifyReasonController,
                            focusNode: specifyReasonFocusNode,
                            decoration: InputDecoration(
                                labelText: 'Specify Reason',
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: new BorderSide(
                                        color: Colors.red, width: 2.0))
                            ),
                          )
                      ),

                    ],
                  ),
                ),
                Visibility(
                  visible: keyBoardVisilityCheck,
                  child:Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                        color: Colors.deepPurple,
                        child: VirtualKeyboard(
                          height: 300,
                          textColor: Colors.white,
                          type: VirtualKeyboardType.Alphanumeric,
                          textController: _keyboardControllerText,
                        )
                    ),
                  )
                )

              ],
            )

          )
        )
    );
  }
}
