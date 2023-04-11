import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rovermd/Model/pri_insurance_model.dart';
import 'package:rovermd/personal_info_reg1.dart';

class InsuranceAndMarketingRegister extends StatefulWidget {

  final String firstName;
  final String middleName;
  final String lastName;
  final String dob;
  final String sex;
  final String phoneNo;
  final String streetAdd;
  final String city;
  final String state;
  final String zipCode;
  final String ethList;
  final String ethIdList;
  final String raceList;
  final String reasonVisit;
  final String specifyReason;

  const InsuranceAndMarketingRegister({Key? key, required this.firstName,required this.middleName,required this.lastName,required this.dob,required this.sex,required this.phoneNo,required this.streetAdd,required this.city,required this.state,required this.zipCode,required this.ethList,required this.ethIdList,required this.raceList,required this.reasonVisit,required this.specifyReason}) : super(key: key);

  @override
  State<InsuranceAndMarketingRegister> createState() => _InsuranceAndMarketingRegisterState();
}

class _InsuranceAndMarketingRegisterState extends State<InsuranceAndMarketingRegister> {
  TextEditingController wcpController = TextEditingController();
  TextEditingController perInjuryController = TextEditingController();
  TextEditingController priInsController = TextEditingController();
  String payerId = "";
  TextEditingController memIdController = TextEditingController();
  TextEditingController grpNoController = TextEditingController();
  TextEditingController marketingTypeController = TextEditingController();
  bool correctInfoAgreeCheck = false;
  bool consenctContactCheck = false;

  final FocusNode wcpFocusNode = FocusNode();
  final FocusNode perInjuryFocusNode = FocusNode();
  final FocusNode priInsFocusNode = FocusNode();
  final FocusNode memIdFocusNode = FocusNode();
  final FocusNode grpNoFocusNode = FocusNode();
  final FocusNode marketingTypeFocusNode = FocusNode();

  String wcpType = "No";
  String perInjuryType = "";
  String marketingType = "";

  showWCPTypeDialog(BuildContext context){
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
                            value: "Yes",
                            groupValue: wcpType,
                            onChanged: (value){
                              setState(() {
                                wcpType = value.toString();//selected value
                              });
                              // print(value);

                            }
                        ),
                      ),
                      Text("Yes"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child:Radio(
                            value: "No",
                            groupValue: wcpType,
                            onChanged: (value){
                              print(value);
                              setState(() {
                                wcpType = value.toString();//selected value
                              });
                            }
                        ),
                      ),
                      Text("No"),
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
                          print("wcpType--$wcpType");
                          Navigator.pop(context);
                          //EasyLoading.show(status: 'Updating Map...');
                          setState(() {
                            wcpController.text = wcpType;
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

  showPerInjuryTypeDialog(BuildContext context){
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
                            value: "Yes",
                            groupValue: perInjuryType,
                            onChanged: (value){
                              setState(() {
                                perInjuryType = value.toString();//selected value
                              });
                              // print(value);

                            }
                        ),
                      ),
                      Text("Yes"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child:Radio(
                            value: "No",
                            groupValue: perInjuryType,
                            onChanged: (value){
                              print(value);
                              setState(() {
                                perInjuryType = value.toString();//selected value
                              });
                            }
                        ),
                      ),
                      Text("No"),
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
                          print("perInjuryType--$perInjuryType");
                          Navigator.pop(context);
                          //EasyLoading.show(status: 'Updating Map...');
                          setState(() {
                            perInjuryController.text = perInjuryType;
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
                ),
              ],
            )


          ],
        );
      },
    );
  }

  showMarketingTypeDialog(BuildContext context){
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
                            value: "AAA",
                            groupValue: marketingType,
                            onChanged: (value){
                              setState(() {
                                marketingType = value.toString();//selected value
                              });
                              // print(value);

                            }
                        ),
                      ),
                      Text("AAA"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child:Radio(
                            value: "BBB",
                            groupValue: marketingType,
                            onChanged: (value){
                              print(value);
                              setState(() {
                                marketingType = value.toString();//selected value
                              });
                            }
                        ),
                      ),
                      Text("BBB"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child:Radio(
                            value: "CCC",
                            groupValue: marketingType,
                            onChanged: (value){
                              print(value);
                              setState(() {
                                marketingType = value.toString();//selected value
                              });
                            }
                        ),
                      ),
                      Text("CCC"),
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
                          print("marketingType--$marketingType");
                          Navigator.pop(context);
                          //EasyLoading.show(status: 'Updating Map...');
                          setState(() {
                            marketingTypeController.text = marketingType;
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
                ),
              ],
            )
          ],
        );
      },
    );
  }

  List<PriInsurance>? priIns;
  PriInsurance? selectedIns;


  showPriInsDialog(BuildContext context, String payerName, int tenantId) async{
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Insurance'),
            content:
            // isLoading ? CircularProgressIndicator() :
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return SingleChildScrollView(
                  child: FutureBuilder(
                    future: utilityMethods.priInsController(payerName, tenantId),
                    builder: (context, data){
                      if(data.hasError){
                        return Text("Unable to get Data: ${data.error}");
                      }else if(data.hasData){
                        List<PriInsurance> priIns = data.data!;
                        return ListBody(
                          children: priIns!.map((PriInsurance priIns){
                            return RadioListTile(
                              title: Text(priIns.payerName),
                              value: priIns,
                              groupValue: selectedIns,
                              onChanged: (PriInsurance? value) {
                                setState(() {
                                  selectedIns = value;
                                });
                              },
                            );
                          }).toList(),
                        );
                      }else{
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(selectedIns);
                  priInsController.text = selectedIns!.payerName;
                  payerId = selectedIns!.payerID;
                  print("payerIdABID----$payerId");
                },
              ),
            ],

          );
        }).then((value) {
      // Update the state after the dialog is dismissed
      setState(() {});
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("INSURANCE \& MARKETING",
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
      bottomNavigationBar: BottomAppBar(
          color: Color(0xFFC0C0C0),
          child: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10.0,
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
                            Navigator.of(context).pop();
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfoRegister(),));
                          },
                          child: Text("BACK"),
                          style: ElevatedButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              )
                          )
                      )
                  )
              ),
              Spacer(),
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
                            try {
                              String firstName = widget.firstName;
                              String middleName = widget.middleName;
                              String lastName = widget.lastName;
                              String dob = widget.dob;
                              String sex = widget.sex;
                              String phoneNo = widget.phoneNo;
                              String streetAdd = widget.streetAdd;
                              String city = widget.city;
                              String state = widget.state;
                              String zipCode = widget.zipCode;
                              String ethList = widget.ethList;
                              String ethIdList = widget.ethIdList;
                              String raceList = widget.raceList;
                              String reasonVisit = widget.reasonVisit;
                              String specifyReason = widget.specifyReason;

                              String primaryInsurance = priInsController.text;
                              //int payerID = int.parse(payerId);
                              String memId = memIdController.text;
                              String grpNo = grpNoController.text;
                              String wcp = wcpController.text;
                              String perInjury = perInjuryController.text;
                              String marketingType = marketingTypeController
                                  .text;

                              List<String> dobParts = dob.split("/");
                              dob = dobParts[2] + "-" + dobParts[0] + "-" +
                                  dobParts[1] + "T00:00:00.288Z";

                              List<Map<String, dynamic>> ethMap = [];
                              List<String> ethListPart = ethList.split(",");
                              List<String> ethIdListPart = ethIdList.split(",");

                              for (int i = 0; i < ethListPart.length; i++) {
                                ethMap.add(
                                    {
                                      "ethnicityId": ethIdListPart[i],
                                      //int.parse(ethIdListPart[i]),
                                      "ethnicity": "${ethListPart[i]}"
                                    }
                                );
                              }
                              // List<Map<String, dynamic>> patientEthnicityList = [ethMap];


                              Map<String, dynamic> patientReg = {
                                "firstName": "$firstName",
                                "middleInitial": "$middleName",
                                "lastName": "$lastName",
                                "dob": "$dob",
                                "race": "$raceList",
                                "phNumber": "$phoneNo",
                                "address1": "$streetAdd",
                                "address2": "",
                                "zipCode": "$zipCode",
                                "city": "$city",
                                "state": "$state",
                                "county": "",
                                "country": "",
                                "sex": "$sex"
                              };

                              Map<String, dynamic> priorityObj = {
                                "id": 0,
                                "priority": "string"
                              };

                              Map<String, dynamic> typeObj = {
                                "id": 0,
                                "type": "string"
                              };

                              Map<String, dynamic> insurance = {
                                "id": payerId,
                                "payerName": "$primaryInsurance"
                              };

                              Map<String, dynamic> patientInsuranceDetails = {
                                "id": 0,
                                "priorityObj": priorityObj,
                                "typeObj": typeObj,
                                "insurance": insurance,
                                "memberId": "$memId",
                                "groupNumber": "$grpNo"
                              };

                              List<Map<
                                  String,
                                  dynamic>> patientInsuranceDetailsList = [
                                patientInsuranceDetails
                              ];

                              Map<String, dynamic> jsonData = {
                                "patientReg": patientReg,
                                "patientEthnicityList": ethMap,
                                "visitDetails": {
                                  "reasonVisit": "$reasonVisit",
                                  "reasonVisitSpecify": "$specifyReason",
                                  "doctorId": 0
                                },
                                "patientInsuranceDetails": patientInsuranceDetailsList
                              };

                              String? resp = await utilityMethods
                                  .registerPatient(jsonData);
                              if (resp!.toUpperCase().contains(
                                  "SUCCESSFULLY")) {
                                // EasyLoading.showSuccess(resp!);
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Color(0xFFC0C0C0),
                                        content: Container(
                                          height: 50.0,
                                          child: Center(
                                            child: Text(resp),
                                          ),
                                        ),
                                        actions: [
                                          Container(
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
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                    MaterialPageRoute(builder: (
                                                        BuildContext context) =>
                                                        PersonalInfoRegister()), (
                                                    Route<
                                                        dynamic> route) => false);
                                                //EasyLoading.show(status: 'Updating Map...');
                                              },
                                              child: Text("OK",
                                                style: TextStyle(
                                                    color: Colors.black
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                                  primary: Colors.transparent,
                                                  shadowColor: Colors
                                                      .transparent,
                                                  elevation: 0,
                                                  textStyle: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight
                                                          .bold)
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                );
                              } else {
                                EasyLoading.showError("Unable to save data");
                              }
                            }catch(e){
                              print("ERROR IN MAKING SOME: $e");
                            }
                          },
                          child: Text("SUBMIT"),
                          style: ElevatedButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              )
                          )
                      )
                  )
              ),
            ],
          )
      ),
      body: Container(
        height: MediaQuery. of(context). size. height,
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
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  readOnly: true,
                  controller: wcpController,
                  focusNode: wcpFocusNode,
                  decoration: InputDecoration(
                      labelText: 'Worker\'s Compensation Policy',
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
                    showWCPTypeDialog(context);
                  },
                )
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  readOnly: true,
                  controller: perInjuryController,
                  focusNode: perInjuryFocusNode,
                  decoration: InputDecoration(
                      labelText: 'Personal Injury',
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
                    showPerInjuryTypeDialog(context);
                  },
                )
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (text){
                    if(text.length == 3){
                      showPriInsDialog(context, text, 8);
                    }
                  },
                  controller: priInsController,
                  focusNode: priInsFocusNode,
                  decoration: InputDecoration(
                      labelText: 'Primary Insurance',
                      fillColor: Colors.white,
                      filled: true,
                      suffix: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            priInsController.clear();
                          }),
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
                  controller: memIdController,
                  focusNode: memIdFocusNode,
                  decoration: InputDecoration(
                      labelText: 'Member Id',
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
                )
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: grpNoController,
                  focusNode: grpNoFocusNode,
                  decoration: InputDecoration(
                      labelText: 'Group Number',
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
                )
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  readOnly: true,
                  controller: marketingTypeController,
                  focusNode: marketingTypeFocusNode,
                  decoration: InputDecoration(
                      labelText: 'How did you find us?',
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
                    showMarketingTypeDialog(context);
                  },
                )
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: CheckboxListTile(
                  side: BorderSide(
                    color: Colors.red,
                    width: 2.0
                  ),
                  checkColor: Colors.green,
                  activeColor: Colors.white,
                  title: Text("I HEREBY AGREE AND CONFIRM THAT ALL MY INFORMATION STATED ABOVE IS ACCURATE.",
                      style:TextStyle(
                          color: Colors.white,
                          fontSize: 14.0)),
                  value: correctInfoAgreeCheck,
                  onChanged: (newValue) {
                    setState(() {
                      correctInfoAgreeCheck = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                )
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: CheckboxListTile(
                  side: BorderSide(
                      color: Colors.red,
                      width: 2.0
                  ),
                  checkColor: Colors.green,
                  activeColor: Colors.white,
                  title: Text("CONSENT TO CONTACT",
                      style:TextStyle(
                          color: Colors.white,
                          fontSize: 14.0)),
                  value: consenctContactCheck,
                  onChanged: (newValue) {
                    setState(() {
                      consenctContactCheck = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                )
            ),


          ],
        ),
      ),

    );
  }
}


