import 'dart:convert';

import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'first_run.dart';
import 'package:decidi/screens/root_app.dart';
import 'package:decidi/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayMyTextEco extends StatefulWidget {
  final List<MyData> bacGradesData;
  final String type;

  const DisplayMyTextEco(this.bacGradesData, this.type, {Key? key})
      : super(key: key);

  @override
  _DisplayMyTextEcoState createState() => _DisplayMyTextEcoState();
}

class _DisplayMyTextEcoState extends State<DisplayMyTextEco> {
  TextEditingController economie = TextEditingController();
  TextEditingController gestion = TextEditingController();
  TextEditingController mathematique = TextEditingController();
  TextEditingController histoireetgeographie = TextEditingController();
  TextEditingController anglais = TextEditingController();
  TextEditingController francais = TextEditingController();
  TextEditingController arabe = TextEditingController();
  TextEditingController philo = TextEditingController();
  TextEditingController info = TextEditingController();
  TextEditingController sport = TextEditingController();
  TextEditingController option = TextEditingController();
  TextEditingController moy = TextEditingController();

  @override
  void initState() {
    super.initState();
    economie.text = widget.bacGradesData[0].x;
    gestion.text = widget.bacGradesData[1].x;
    mathematique.text = widget.bacGradesData[2].x;
    histoireetgeographie.text = widget.bacGradesData[3].x;
    anglais.text = widget.bacGradesData[4].x;
    francais.text = widget.bacGradesData[5].x;
    arabe.text = widget.bacGradesData[6].x;
    philo.text = widget.bacGradesData[7].x;
    info.text = widget.bacGradesData[8].x;
    sport.text = widget.bacGradesData[9].x;
    option.text = widget.bacGradesData[10].x;
    moy.text = widget.bacGradesData[11].x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Degrees list",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5, top: 5),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Bac type is :" + widget.type),
              SizedBox(
                height: 20,
              ),
              //----------------------------------------
              //----------------------------------------
              TextField(
                controller: economie,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Economie :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: gestion,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Gestion :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: mathematique,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Mathematique :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: histoireetgeographie,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Histoire et Geographie :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: anglais,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Anglais :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: francais,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Francais :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: arabe,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Arabe :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: philo,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Philo :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              TextField(
                controller: info,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Info :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: sport,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Sport :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: option,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Option :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: moy,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Moyenne :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),

              //----------------------------------------
              //----------------------------------------
              SizedBox(
                height: 20,
              ),
              IconButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final userid = prefs.getString("userId");
                  final user =
                      Provider.of<DataProvider>(context, listen: false).user;
                  user.bacType = widget.type.toUpperCase();
                  Provider.of<DataProvider>(context, listen: false)
                      .setUser(user);
                  Map<String, dynamic> userData = {
                    "userId": userid,
                    "bacType": widget.type.toUpperCase(),
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=UTF-8"
                  };

                  await http.put(Uri.http(baseUrl, "/updateuserbac"),
                      headers: headers, body: json.encode(userData));
                  Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => RootApp(),
                    ),
                  );
                },
                icon: Icon(Icons.navigate_next),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
