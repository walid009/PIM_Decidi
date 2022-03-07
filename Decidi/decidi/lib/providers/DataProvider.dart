import 'dart:convert';
import 'dart:io';
import 'package:decidi/models/course.dart';
import 'package:decidi/screens/course/detail_course.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';

class DataProvider with ChangeNotifier {
  late List<Course> listCourse = [];
  late bool exist = true;

  Future<void> fetchCourse() async {
    List<Course> tempcars = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allcourses"));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      print(carsFromServer[i]["_id"].toString());

      print(carsFromServer[i]["title"]);
      print(carsFromServer[i]["description"]);
      tempcars.add(Course(
          carsFromServer[i]["_id"],
          carsFromServer[i]["image"],
          carsFromServer[i]["title"],
          carsFromServer[i]["description"],
          carsFromServer[i]["price"],
          carsFromServer[i]["capacity"],
          carsFromServer[i]["nbParticipant"],
          carsFromServer[i]["participants"]));
    }
    listCourse = tempcars;
    notifyListeners();
  }

  Future<void> addCourse(String text, String capacity, String price,
      String description, File file) async {
    //create multipart request for POST or PATCH method
    var request =
        http.MultipartRequest("POST", Uri.http(baseUrl, "/createcourse"));
    //add text fields
    request.fields["title"] = text;
    request.fields["capacity"] = capacity;
    request.fields["price"] = price;
    request.fields["description"] = description;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    /*Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8"
    };
    await http.post(Uri.http(baseUrl, "/createcourse"),
        //headers: headers,
        body: carBody);*/

    await fetchCourse();
  }

  Future<void> participateToCourse(String idc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await http.put(Uri.http(
        baseUrl,
        "/particpatetocourse/" +
            prefs.getString("userId").toString() +
            "/" +
            idc));

    await fetchCourse();
  }

  Future<void> deleteCourse(String id) async {
    await http.delete(Uri.http(baseUrl, "/deletecourse/" + id));

    await fetchCourse();
  }
}
