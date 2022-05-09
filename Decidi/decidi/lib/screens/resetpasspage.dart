import 'dart:convert';
import 'dart:math';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/SignInScreen.dart';
import 'package:decidi/screens/admin/dashboard_admin.dart';
import 'package:decidi/screens/course/organisateur/NavigationBottom.dart';
import 'package:decidi/screens/root_app.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'course/organisateur/NavigationBottom.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:decidi/models/user.dart' as AppUser;

class ResetPageScreen extends StatefulWidget {
  final String code;
  final String email;

  const ResetPageScreen({Key? key, required this.code, required this.email})
      : super(key: key);
  @override
  _ResetPageScreenState createState() => _ResetPageScreenState();
}

class _ResetPageScreenState extends State<ResetPageScreen> {
  late TextEditingController codeController;
  late TextEditingController passwordController;

  bool passwordVisibility = false;

  late String? _password;
  late String? _code;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFFF1F4F8),
        foregroundColor: Colors.black,
        elevation: 0,
        shadowColor: darker,
      ),
      backgroundColor: const Color(0xFFF1F4F8),
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
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Center(
                          child: Text(
                            'Decidi',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF090F13),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Text(
                                'Write code and New password',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                          child: TextFormField(
                            controller: codeController,
                            onSaved: (text) {
                              _code = text;
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please put your Rest Code';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Rest Code',
                              labelStyle: const TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              hintText: 'Enter Rest Code',
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
                                  const EdgeInsetsDirectional.fromSTEB(
                                      24, 24, 20, 24),
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
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                          child: TextFormField(
                            controller: passwordController,
                            onSaved: (text) {
                              _password = text;
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please put your New Password';
                              }
                              return null;
                            },
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              labelStyle: const TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              hintText: 'Enter your New Password...',
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
                                  const EdgeInsetsDirectional.fromSTEB(
                                      24, 24, 20, 24),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF95A1AC),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF1D2429),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            print("button pressed");
                            if (_keyForm.currentState!.validate()) {
                              _keyForm.currentState!.save();
                              if (_code != widget.code) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AlertDialog(
                                      title: Text("Information"),
                                      content: Text("Code wrong"),
                                    );
                                  },
                                );
                              } else {
                                Map<String, dynamic> userData = {
                                  "password": _password,
                                  "email": widget.email,
                                };
                                print(userData);

                                Map<String, String> headers = {
                                  "Content-Type":
                                      "application/json; charset=UTF-8"
                                };

                                http
                                    .post(Uri.http(baseUrl, "/updatemail"),
                                        headers: headers,
                                        body: json.encode(userData))
                                    .then((http.Response response) async {
                                  if (response.statusCode == 200) {
                                    Map<String, dynamic> userData =
                                        json.decode(response.body);
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text("Information"),
                                          content: Text("Password updated"),
                                        );
                                      },
                                    );
                                    Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            SignInScreen(),
                                      ),
                                    );
                                  } else if (response.statusCode == 404) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text("Information"),
                                          content: Text("Code wrong"),
                                        );
                                      },
                                    );
                                  } else if (response.statusCode == 400) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text("Information"),
                                          content: Text(
                                              "Username et/ou mot de passe incorrect !"),
                                        );
                                      },
                                    );
                                  }
                                });
                              }
                            }
                          },
                          child: Container(
                              width: 150,
                              height: 50,
                              child: Center(
                                  child: Text(
                                'Change password',
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
            ),
          ),
        ),
      ),
    );
  }
}
