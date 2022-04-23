import 'dart:convert';

import 'package:decidi/providers/DataProvider.dart';
import 'first_run.dart';
import 'package:decidi/screens/root_app.dart';
import 'package:decidi/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayMyTextInfo extends StatefulWidget {
  final List<MyData> bacGradesData;
  final String type;

  const DisplayMyTextInfo(this.bacGradesData, this.type, {Key? key}) : super(key: key);

  @override
  _DisplayMyTextInfoState createState() => _DisplayMyTextInfoState();
}

class _DisplayMyTextInfoState extends State<DisplayMyTextInfo> {

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
}
