import 'dart:convert';

import 'package:decidi/models/user.dart';
import 'package:decidi/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/utils/data.dart';
import 'package:decidi/widgets/custom_image.dart';
import 'package:decidi/widgets/setting_box.dart';
import 'package:decidi/widgets/setting_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignInScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  final Map<String, dynamic> user;
  const SettingPage({Key? key, required this.user}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState(user);
}

class _SettingPageState extends State<SettingPage> {
  _SettingPageState(this.user);

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final Map<String, dynamic> user;
  late String? _firstname = user["firstName"];
  late String? _lastname = user["lastName"];
  late String? _password;
  late String? Npassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: appBgColor,
          foregroundColor: Colors.black,
          elevation: 0,
          title: getHeader()),
      body: Form(
        key: _keyForm,
        child: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 12),
                  child: TextFormField(
                    initialValue: _firstname,
                    onSaved: (text) {
                      _firstname = text;
                    },
                    // ignore: body_might_complete_normally_nullable
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Put your Name";
                      }
                    },

                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Your name...',
                      labelStyle: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      hintText: 'Enter your name...',
                      hintStyle: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFDBE2E7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFDBE2E7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF1D2429),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            _keyForm.currentState!.save();
                            print("button ^ressed");
                            Map<String, dynamic> userData = {
                              "firstName": _firstname,
                              "email": user["email"],
                            };

                            Map<String, String> headers = {
                              "Content-Type": "application/json; charset=UTF-8"
                            };

                            http
                                .put(
                                    Uri.http(
                                        baseUrl, "/updateuser/" + user["_id"]),
                                    headers: headers,
                                    body: json.encode(userData))
                                .then((http.Response response) async {
                              if (response.statusCode == 200) {
                                Map<String, dynamic> userData =
                                    json.decode(response.body);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AlertDialog(
                                      title: Text("Succes"),
                                      content: Text("User Update with Succes"),
                                    );
                                  },
                                );
                              } else if (response.statusCode == 404) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AlertDialog(
                                      title: Text("Fail"),
                                      content: Text("User Did not Update !"),
                                    );
                                  },
                                );
                              }
                            });
                          }
                        },
                        child: Container(
                            width: 150,
                            height: 50,
                            child: Center(
                                child: Text(
                              'Update',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF090F13),
                          elevation: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  getHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Setting",
            style: TextStyle(
                color: textColor, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
