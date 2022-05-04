import 'dart:convert';
import 'dart:io';
import 'package:decidi/models/course.dart';
import 'package:decidi/models/group.dart';
import 'package:decidi/models/image_portfolio.dart';
import 'package:decidi/models/message.dart';
import 'package:decidi/models/post.dart';
import 'package:decidi/models/proposition.dart';
import 'package:decidi/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/course/course_chart.dart';
import '../utils/constant.dart';

class DataProvider with ChangeNotifier {
  late int nbrCoach = 0;
  late List<Course> listCourse = [];
  late List<GDPData> listStatistiquesCourse = [];
  late List<Course> listOfMyCourse = [];
  late List<ImagePortfolio> listImages = [];
  late List<User> listusers = [];
  late List<Proposition> listpropositions = [];
  late List<Proposition> listpropositionsBacType = [];
  late List<Group> listGroup = [];
  late List<Post> listPost = [];
  late List<Message> listMsg = [];

  late User user =
      User("id", "firstName", "lastName", "email", "role", "type", 0000);
  late List<User> listUsers = [];
  late List<User> listUsersCoach = [];
  late List<User> listUsersUser = [];
  late bool exist = true;

  void setUser(User u) {
    user = u;
  }

  Future<void> fetchImagePortfolio(String idUser) async {
    List<ImagePortfolio> tempcars = [];
    http.Response response =
        await http.get(Uri.http(baseUrl, "/getAllMyCv/" + idUser));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      tempcars.add(ImagePortfolio(
        carsFromServer[i]["_id"],
        carsFromServer[i]["urlimage"],
        carsFromServer[i]["iduser"],
        carsFromServer[i]["title"],
      ));
    }
    listImages = tempcars;
    notifyListeners();
  }

  Future<void> addCertificat(String text, String userId, File file) async {
    //create multipart request for POST or PATCH method
    var request =
        http.MultipartRequest("POST", Uri.http(baseUrl, "/uploadcv/" + userId));
    //add text fields
    request.fields["title"] = text;
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

    await fetchImagePortfolio(userId);
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
          carsFromServer[i]["type"],
          carsFromServer[i]["description"],
          carsFromServer[i]["price"],
          carsFromServer[i]["capacity"],
          carsFromServer[i]["nbParticipant"],
          carsFromServer[i]["participants"]));
    }
    listCourse = tempcars;
    notifyListeners();
  }

  Future<void> fetchCourseStatistique() async {
    List<GDPData> tempcars = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allcourses"));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      tempcars.add(GDPData(carsFromServer[i]["title"],
          carsFromServer[i]["participants"].length));
    }
    listStatistiquesCourse = tempcars;
    notifyListeners();
  }

  Future<void> fetchMyCourse(String email) async {
    List<Course> tempcars = [];
    http.Response response =
        await http.get(Uri.http(baseUrl, "/listofcourseforthisuser/" + email));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      tempcars.add(Course(
          carsFromServer[i]["_id"],
          carsFromServer[i]["image"],
          carsFromServer[i]["title"],
          carsFromServer[i]["type"],
          carsFromServer[i]["description"],
          carsFromServer[i]["price"],
          carsFromServer[i]["capacity"],
          carsFromServer[i]["nbParticipant"],
          carsFromServer[i]["participants"]));
    }
    listOfMyCourse = tempcars;
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

  Future<void> UpdateCourse(Map<String, dynamic> courseBody) async {
    print("update" + courseBody["_id"]);
    await http.put(Uri.http(baseUrl, "/updatecourse/" + courseBody["_id"]),
        body: courseBody);

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
          PropositionsFromServer[i]["Bac"],
          PropositionsFromServer[i]["Code"],
          PropositionsFromServer[i]["Filiere"],
          PropositionsFromServer[i]["Universite"],
          PropositionsFromServer[i]["Etablissement"],
          PropositionsFromServer[i]["Gouvernorat"],
          PropositionsFromServer[i]["Criteres"],
          PropositionsFromServer[i]["Duree"],
          PropositionsFromServer[i]["Score"],
        ),
      );
    }

    listpropositions = tempproposition;
    notifyListeners();
  }

  Future<void> fetchPropositionsByBac() async {
    List<Proposition> tempproposition = [];
    http.Response response =
        await http.get(Uri.http(baseUrl, "/allproposition"));

    List<dynamic> PropositionsFromServer = json.decode(response.body);

    for (int i = 0; i < PropositionsFromServer.length; i++) {
      if (PropositionsFromServer[i]["Bac"] == user.bacType)
        tempproposition.add(
          Proposition(
            PropositionsFromServer[i]["_id"],
            PropositionsFromServer[i]["Bac"],
            PropositionsFromServer[i]["Code"],
            PropositionsFromServer[i]["Filiere"],
            PropositionsFromServer[i]["Universite"],
            PropositionsFromServer[i]["Etablissement"],
            PropositionsFromServer[i]["Gouvernorat"],
            PropositionsFromServer[i]["Criteres"],
            PropositionsFromServer[i]["Duree"],
            PropositionsFromServer[i]["Score"],
          ),
        );
    }

    listpropositionsBacType = tempproposition;
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

  Future<void> fetchPosts(String idGroup) async {
    List<Post> temp = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allposts"));
    List<dynamic> dataFromServer = json.decode(response.body);
    for (int i = 0; i < dataFromServer.length; i++) {
      if (idGroup == dataFromServer[i]["idGroup"])
        temp.add(Post(
          dataFromServer[i]["_id"],
          dataFromServer[i]["idCreater"],
          dataFromServer[i]["description"],
          dataFromServer[i]["like"],
          dataFromServer[i]["idGroup"],
        ));
    }
    listPost = temp;
    notifyListeners();
  }

  Future<void> addPost(Map<String, dynamic> postBody, String idGroup) async {
    await http.post(Uri.http(baseUrl, "/createpost"), body: postBody);

    await fetchPosts(idGroup);
  }

  Future<void> fetchMessages(String idGroup) async {
    List<Message> temp = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allmessages"));
    List<dynamic> dataFromServer = json.decode(response.body);
    for (int i = 0; i < dataFromServer.length; i++) {
      print(dataFromServer[i]);
      if (idGroup == dataFromServer[i]["idGroup"])
        temp.add(Message(
          dataFromServer[i]["_id"],
          dataFromServer[i]["idSender"],
          dataFromServer[i]["description"],
          dataFromServer[i]["idGroup"],
        ));
    }
    listMsg = temp;
    notifyListeners();
  }

  Future<void> addMsg(Map<String, dynamic> postBody, String idGroup) async {
    await http.post(Uri.http(baseUrl, "/createmessage"), body: postBody);

    await fetchMessages(idGroup);
  }

/*
  Future<void> fetchUsers() async {
    List<User> tempuser = [];
    http.Response response =
    await http.get(Uri.http(baseUrl, "/allusers"));

    nbrCoach = 0 ;
    List<dynamic> UsersFromServer = json.decode(response.body);

    for (int i = 0; i < UsersFromServer.length; i++) {
      if (UsersFromServer[i]["role"] == "coach"){
        nbrCoach++;
      }

      tempuser.add(
        User(
          UsersFromServer[i]["_id"],
          UsersFromServer[i]["firstName"],
          "",
          UsersFromServer[i]["email"],
          "",
          "",
        ),
      );

    }


    listusers = tempuser;
    notifyListeners();
  }
*/
  Future<void> fetchUsers() async {
    List<User> tempcars = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allusers"));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      tempcars.add(User(
        carsFromServer[i]["_id"],
        carsFromServer[i]["firstName"],
        carsFromServer[i]["firstName"],
        carsFromServer[i]["email"],
        carsFromServer[i]["role"],
        carsFromServer[i]["bacType"],
        carsFromServer[i]["codeAI"],
      ));
    }
    listUsers = tempcars;
    notifyListeners();
  }

  Future<void> fetchUserscCoach() async {
    List<User> tempcars = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allusers"));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      if (carsFromServer[i]["role"] == "coach") {
        tempcars.add(User(
          carsFromServer[i]["_id"],
          carsFromServer[i]["firstName"],
          carsFromServer[i]["firstName"],
          carsFromServer[i]["email"],
          carsFromServer[i]["role"],
          carsFromServer[i]["bacType"],
          carsFromServer[i]["codeAI"],
        ));
      }
    }
    listUsersCoach = tempcars;
    notifyListeners();
  }

  Future<void> fetchUserscUsers() async {
    List<User> tempcars = [];
    http.Response response = await http.get(Uri.http(baseUrl, "/allusers"));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      if (carsFromServer[i]["role"] == "client") {
        tempcars.add(User(
          carsFromServer[i]["_id"],
          carsFromServer[i]["firstName"],
          carsFromServer[i]["firstName"],
          carsFromServer[i]["email"],
          carsFromServer[i]["role"],
          carsFromServer[i]["bacType"],
          carsFromServer[i]["codeAI"],
        ));
      }
    }
    listUsersUser = tempcars;
    notifyListeners();
  }
}
