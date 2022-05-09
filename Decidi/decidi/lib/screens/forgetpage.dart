import 'dart:convert';
import 'dart:math';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/admin/dashboard_admin.dart';
import 'package:decidi/screens/course/organisateur/NavigationBottom.dart';
import 'package:decidi/screens/resetpasspage.dart';
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

class ForgetScreen extends StatefulWidget {
  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;

  late String? _email;
  late GoogleSignInAccount? googleuserr;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
  }

  late String code;

  String randCode() {
    var rng = Random();

    return rng.nextInt(9999).toString();
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
                                'Reset your password here write your email first',
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
                            onSaved: (text) {
                              _email = text;
                            },
                            // ignore: body_might_complete_normally_nullable
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Please Put your Email";
                              } else {
                                bool emailValid = RegExp(
                                        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                    .hasMatch(value);
                                if (!emailValid) {
                                  return "Email not valide";
                                }
                              }
                            },
                            controller: emailAddressController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Your email address...',
                              labelStyle: const TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              hintText: 'Enter your email...',
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
                        // Padding(
                        //   padding:
                        //       const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                        //   child: TextFormField(
                        //     controller: passwordController,
                        //     onSaved: (text) {
                        //       _password = text;
                        //     },
                        //     validator: (String? value) {
                        //       if (value!.isEmpty) {
                        //         return 'Please put your Rest Code';
                        //       }
                        //       return null;
                        //     },
                        //     decoration: InputDecoration(
                        //       labelText: 'Rest Code',
                        //       labelStyle: const TextStyle(
                        //         fontFamily: 'Lexend Deca',
                        //         color: Color(0xFF57636C),
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.normal,
                        //       ),
                        //       hintText: 'Enter Rest Code',
                        //       hintStyle: const TextStyle(
                        //         fontFamily: 'Lexend Deca',
                        //         color: Color(0xFF57636C),
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.normal,
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //           color: Color(0xFFDBE2E7),
                        //           width: 2,
                        //         ),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(
                        //           color: Color(0xFFDBE2E7),
                        //           width: 2,
                        //         ),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       filled: true,
                        //       fillColor: Colors.white,
                        //       contentPadding:
                        //           const EdgeInsetsDirectional.fromSTEB(
                        //               24, 24, 20, 24),
                        //     ),
                        //     style: const TextStyle(
                        //       fontFamily: 'Lexend Deca',
                        //       color: Color(0xFF1D2429),
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.normal,
                        //     ),
                        //   ),
                        // ),
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
                              code = randCode();
                              Map<String, dynamic> userData = {
                                "email": _email,
                                "code": code,
                              };
                              print(userData);

                              Map<String, String> headers = {
                                "Content-Type":
                                    "application/json; charset=UTF-8"
                              };

                              http
                                  .post(Uri.http(baseUrl, "/sendmail"),
                                      headers: headers,
                                      body: json.encode(userData))
                                  .then((http.Response response) async {
                                if (response.statusCode == 200) {
                                  Map<String, dynamic> userData =
                                      json.decode(response.body);
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          ResetPageScreen(
                                        code: code,
                                        email: _email!,
                                      ),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialog(
                                        title: Text("Information"),
                                        content: Text("Email not found"),
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
                                'Send mail',
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
