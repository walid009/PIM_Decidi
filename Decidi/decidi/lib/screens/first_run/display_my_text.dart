import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/root_app.dart';
import 'package:decidi/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/first_run_data.dart';
import 'first_run.dart';
import 'dart:convert';

class DisplayNotes extends StatefulWidget {
  final List<MyData> bacGradesData;
  final String type;
  const DisplayNotes(this.bacGradesData, this.type, {Key? key})
      : super(key: key);

  @override
  _DisplayNotesState createState() => _DisplayNotesState();
}

class _DisplayNotesState extends State<DisplayNotes> {
  int i = -1;
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text("Bac type is :" + widget.type),
            ...widget.bacGradesData.map((element) {
              i++;
              return ListTile(
                trailing: Text(element.toString()),
                title: getSubjects(widget.type),
              );
            }),
            SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final userid = prefs.getString("userId");
                final user =
                    Provider.of<DataProvider>(context, listen: false).user;
                user.bacType = widget.type.toUpperCase();
                Provider.of<DataProvider>(context, listen: false).setUser(user);
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
    );
  }

  getSubjects(type) {
    switch (type) {
      case "Info":
        {
          return Text(InfoMat[i]);
        }

      case "Science":
        {
          return Text(ScienceMat[i]);
        }

      case "Math":
        {
          return Text(MathMat[i]);
        }
      case "Tech":
        {
          return Text(TechMat[i]);
        }

      case "Lettre":
        {
          return Text(LettreMat[i]);
        }

      case "Eco":
        {
          return Text(EcoMat[i]);
        }
      default:
        {
          return Text("SportMat[i]");
        }
    }
  }
}
