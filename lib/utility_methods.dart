import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:rovermd/Model/ethnicity_race_model.dart';
import 'package:rovermd/Model/gender_model.dart';
import 'package:rovermd/Model/pri_insurance_model.dart';

class UtilityMethods{

  String BaseUrl = "http://v2.rovermd.com:7788/api";

  Widget getLogo(String imagePath, double _minimumPadding) {
    AssetImage assetImage = AssetImage(imagePath);
    Image image = Image(
      image: assetImage,
      // width: 100,
      // height: 100,
    );
    return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 5));
  }


  Future<List<Gender>?> genderController() async {
    try {
      var jsonData = null;
      Uri uri = Uri.parse("$BaseUrl/gender/find/all");
      // Uri uri = Uri.parse("$BaseUrl/gender/find/all");
      print(uri.toString());
      var response = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Charset': 'utf-8',
            'Access-Control-Allow-Origin': '*'
          });
      // print("response---$response");
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body.toString());
        List<dynamic> genderData = jsonData;
        print("jsonData---$jsonData");

        return genderData.map((data) => Gender.fromJson(data)).toList();

      }else{
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error in genderController Funtion: $e");
    }
  }

  Future<List<Ethnicity>?> ethnicityController() async {
    try {
      var jsonData = null;
      Uri uri = Uri.parse("$BaseUrl/ethnicity/all");
      print(uri.toString());
      var response = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Charset': 'utf-8'
          });
      // print(response);
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body.toString());
        List<dynamic> ethData = jsonData;
        print("jsonData---$jsonData");

        // return genderData.map((data) => Gender.fromJson(data)).toList();
        return ethData.map((x) => Ethnicity.fromJson(x)).toList();
      }else{
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error in ethinicityController Funtion: $e");
    }
  }

  Future<List<Race>?> raceController() async {
    try {
      var jsonData = null;
      Uri uri = Uri.parse("$BaseUrl/race/all");
      print(uri.toString());
      var response = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'Charset': 'utf-8'
          });
      // print(response);
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body.toString());
        List<dynamic> raceData = jsonData;
        print("jsonData---$jsonData");

        // return genderData.map((data) => Gender.fromJson(data)).toList();
        return raceData.map((x) => Race.fromJson(x)).toList();
      }else{
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error in ethinicityController Funtion: $e");
    }
  }

  Future<List<PriInsurance>?> priInsController(String payerName, int tenantId) async {
    try {
      String BaseUrl = "http://v2.rovermd.com:8080/api/professionalpayer/find/max";
      var jsonData = null;
      Uri uri = Uri.parse("$BaseUrl/$payerName");
      final headers ={
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'X-TenantID': '$tenantId'
      };
      print("URI HERE-- "+uri.toString());
      var response = await http.get(uri,
          headers: headers);
      // print(response);
      // print(response.headers);
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body.toString());
        List<dynamic> priInsData = jsonData;
        print("jsonData---$jsonData");

        // return genderData.map((data) => Gender.fromJson(data)).toList();
        return priInsData.map((x) => PriInsurance.fromJson(x)).toList();
      }else{
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error in Pri Insurnace Controller Funtion: $e");
    }
  }

  Future<String?> registerPatient(Map<String, dynamic> patientInfo) async{
    String message = "";
    try {
      Uri uri = Uri.parse("http://v2.rovermd.com:8484/patient/register");
      var response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Charset': 'utf-8'
          },
          body: jsonEncode(patientInfo));
          // body: jsonString);
      print("responseBody--${response.body.toString()}");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body.toString());
        if(jsonData['status'] == true){
          message =  jsonData['message'];
        }else{
          message = "Failed";
        }
      }else{
        // EasyLoading.showError("Unable to save data");
        message = "Failed";
      }

    }catch(e){
      print("Error in saving patient info: $e");
    }

    return message;

  }



}