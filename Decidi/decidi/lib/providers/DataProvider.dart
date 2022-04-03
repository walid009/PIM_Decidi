import 'dart:convert';
import 'dart:io';
import 'package:decidi/models/course.dart';
import 'package:decidi/models/group.dart';
import 'package:decidi/models/message.dart';
import 'package:decidi/models/post.dart';
import 'package:decidi/models/proposition.dart';
import 'package:decidi/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';

class DataProvider with ChangeNotifier {
  late List<Course> listCourse = [];
  late List<Proposition> listpropositions = [];
  late List<Group> listGroup = [];
  late List<Post> listPost = [];
  late List<Message> listMsg = [];
  late User user = User("id", "firstName", "lastName", "email", "role");

  late bool exist = true;

  void setUser(User u) {
    user = u;
  }

  Future<void> fetchCourse() async {
    List<Course> tempcars = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allcourses"));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
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

  //-------------------------------------------------------------------
  //-------------------------------------------------------------------
  //-------------------------------------------------------------------

  Future<void> addProposition(Map<String, dynamic> propositionBody) async {
    await http.post(Uri.http(baseUrl, "/createproposition"),
        body: propositionBody);

    await fetchPropositions();
  }

  Future<void> updateProposition(Map<String, dynamic> propositionBody) async {
    print("update" + propositionBody["_id"]);
    await http.put(
        Uri.http(baseUrl, "/updateproposition/" + propositionBody["_id"]),
        body: propositionBody);

    await fetchPropositions();
  }

  Future<void> deleteProposition(String id) async {
    print("delete " + id);
    await http.delete(Uri.http(baseUrl, "/deleteproposition/" + id));

    await fetchPropositions();
  }

  Future<void> fetchPropositions() async {
    List<Proposition> tempproposition = [];
    http.Response response =
        await http.get(Uri.http(baseUrl, "/allproposition"));

    List<dynamic> PropositionsFromServer = json.decode(response.body);

    for (int i = 0; i < PropositionsFromServer.length; i++) {
      tempproposition.add(
        Proposition(
          PropositionsFromServer[i]["_id"],
          PropositionsFromServer[i]["academicBackground"],
          PropositionsFromServer[i]["universityName"],
          PropositionsFromServer[i]["description"],
        ),
      );
    }
    listpropositions = tempproposition;
    notifyListeners();
  }

  //-------------------------------------------------------------------
  //-------------------------------------------------------------------
  //-------------------------------------------------------------------
  Future<void> fetchGroups() async {
    List<Group> tempgroups = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allgroups"));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      tempgroups.add(Group(
        carsFromServer[i]["_id"],
        carsFromServer[i]["nameGroup"],
      ));
    }
    listGroup = tempgroups;
    notifyListeners();
  }

  Future<void> addGroup(Map<String, dynamic> groupBody) async {
    await http.post(Uri.http(baseUrl, "/creategroup"), body: groupBody);

    await fetchGroups();
  }

  Future<void> fetchPosts() async {
    List<Post> temp = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allposts"));
    List<dynamic> dataFromServer = json.decode(response.body);
    for (int i = 0; i < dataFromServer.length; i++) {
      temp.add(Post(
        dataFromServer[i]["_id"],
        dataFromServer[i]["idCreater"],
        dataFromServer[i]["description"],
        dataFromServer[i]["like"],
      ));
    }
    listPost = temp;
    notifyListeners();
  }

  Future<void> addPost(Map<String, dynamic> postBody) async {
    await http.post(Uri.http(baseUrl, "/createpost"), body: postBody);

    await fetchPosts();
  }

  Future<void> fetchMessages() async {
    List<Message> temp = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allmessages"));
    List<dynamic> dataFromServer = json.decode(response.body);
    for (int i = 0; i < dataFromServer.length; i++) {
      print(dataFromServer[i]);
      temp.add(Message(
        dataFromServer[i]["_id"],
        dataFromServer[i]["idSender"],
        dataFromServer[i]["description"],
      ));
    }
    listMsg = temp;
    notifyListeners();
  }

  Future<void> addMsg(Map<String, dynamic> postBody) async {
    await http.post(Uri.http(baseUrl, "/createmessage"), body: postBody);

    await fetchMessages();
  }
}
