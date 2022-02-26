import 'dart:convert';
import 'package:decidi/models/course.dart';
import 'package:decidi/screens/course/k_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  late List<Course> cars = [];

  Future<void> fetchCourse() async {
    List<Course> tempcars = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allcourses"));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      print(carsFromServer[i]["_id"].toString());

      print(carsFromServer[i]["title"]);
      print(carsFromServer[i]["description"]);
      tempcars.add(Course(
          carsFromServer[i]["_id"].toString(),
          "" /*"http://10.0.2.2:8000/images/" + carsFromServer[i]["image"]*/,
          carsFromServer[i]["title"],
          carsFromServer[i]["price"]));
    }
    cars = tempcars;
    notifyListeners();
  }

  Future<void> addCourse(Map<String, dynamic> carBody) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8"
    };
    await http.post(Uri.http(baseUrl, "/createcourse"),
        //headers: headers,
        body: carBody);

    await fetchCourse();
  }

  Future<void> deleteCourse(String id) async {
    await http.delete(Uri.http(baseUrl, "/deletecourse/" + id));

    await fetchCourse();
  }
}
