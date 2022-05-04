import 'dart:convert';

import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/SignInScreen.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/utils/first_run_data.dart';
import 'first_run.dart';
import 'package:decidi/screens/root_app.dart';
import 'package:decidi/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayMyTextSport extends StatefulWidget {
  final List<MyData> bacGradesData;
  final String type;

  const DisplayMyTextSport(this.bacGradesData, this.type, {Key? key})
      : super(key: key);

  @override
  _DisplayMyTextSportState createState() => _DisplayMyTextSportState();
}

class _DisplayMyTextSportState extends State<DisplayMyTextSport> {
  TextEditingController specialitesportive = TextEditingController();
  TextEditingController science = TextEditingController();
  TextEditingController physique = TextEditingController();
  TextEditingController mathematique = TextEditingController();
  TextEditingController anglais = TextEditingController();
  TextEditingController francais = TextEditingController();
  TextEditingController arabe = TextEditingController();
  TextEditingController philo = TextEditingController();
  TextEditingController sport = TextEditingController();
  TextEditingController info = TextEditingController();
  TextEditingController moy = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.bacGradesData.length == 11) {
      specialitesportive.text = widget.bacGradesData[0].x;
      science.text = widget.bacGradesData[1].x;
      physique.text = widget.bacGradesData[2].x;
      mathematique.text = widget.bacGradesData[3].x;
      anglais.text = widget.bacGradesData[4].x;
      francais.text = widget.bacGradesData[5].x;
      arabe.text = widget.bacGradesData[6].x;
      philo.text = widget.bacGradesData[7].x;
      sport.text = widget.bacGradesData[8].x;
      info.text = widget.bacGradesData[9].x;
      moy.text = widget.bacGradesData[10].x;
    }
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
                controller: specialitesportive,
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
                  labelText: "Specialite sportive :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: science,
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
                  labelText: "Science :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: physique,
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
                  labelText: "Physique :",
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
                  final bac = items.indexOf(widget.type) + 1;

                  final url = "BAC=" +
                      bac.toString() +
                      "&Moyenne=" +
                      moy.text +
                      "&SpecialiteSport=" +
                      specialitesportive.text +
                      "&Physique=" +
                      physique.text +
                      "&Science=" +
                      science.text +
                      "&Math=" +
                      mathematique.text +
                      "&Anglais=" +
                      anglais.text +
                      "&Francais=" +
                      francais.text +
                      "&Arabe=" +
                      arabe.text +
                      "&Philo=" +
                      philo.text +
                      "&Info=" +
                      info.text +
                      "&Sport=" +
                      sport.text;
                  final response = await http.get(
                    Uri.parse("http://10.0.2.2:2220/?" + url),
                  );
                  var code =
                      response.body.substring(1, response.body.length - 1);
                  print(code);
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
                    "codeAI": int.parse(code)
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=UTF-8"
                  };

                  await http.put(Uri.http(baseUrl, "/updateuserbac"),
                      headers: headers, body: json.encode(userData));
                  Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => SignInScreen(),
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
