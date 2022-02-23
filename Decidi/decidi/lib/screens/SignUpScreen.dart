// ignore_for_file: unused_field, body_might_complete_normally_nullable

import 'dart:convert';
import 'package:decidi/screens/SignInScreen.dart';
import 'package:decidi/screens/first_run.dart';
import 'package:decidi/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController confirmPasswordController;
  late bool confirmPasswordVisibility;
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  late String? _email;
  late String? _password;
  late String? _passwordconfirmation;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasPasswordmatch = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;
    });
  }

  onPasswordmat(String password, String pass) {
    setState(() {
      _hasPasswordmatch = false;
      if (pass == password) _hasPasswordmatch = true;
    });
  }

  @override
  void initState() {
    super.initState();
    confirmPasswordController = TextEditingController();
    confirmPasswordVisibility = false;
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
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
                    padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Row(
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     Image.asset(
                        //       'assets/images/logoTranslation@3x.png',
                        //       width: 50,
                        //       height: 50,
                        //       fit: BoxFit.fitWidth,
                        //     ),
                        //   ],
                        // ),
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 140,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                ),
                                alignment: AlignmentDirectional(-1, 0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            SignInScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF95A1AC),
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 140,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                ),
                                alignment: AlignmentDirectional(-1, 0),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Get started by creating an account below.',
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                          child: TextFormField(
                            controller: emailAddressController,
                            onSaved: (text) {
                              _email = text;
                            },
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
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Your email address...',
                              labelStyle: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              hintText: 'Enter your email...',
                              hintStyle: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  24, 24, 20, 24),
                            ),
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF1D2429),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                          child: TextFormField(
                            controller: passwordController,
                            onChanged: (password) {
                              onPasswordChanged(password);
                              _password = password;
                            },
                            onSaved: (text) {
                              _password = text;
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please put your Password';
                              } else {
                                if (_isPasswordEightCharacters == false)
                                  return 'Password Must have at least 8 charactar';
                                if (_hasPasswordOneNumber == false)
                                  return 'Password Must have at least 1 number';
                                if (_hasPasswordmatch == false)
                                  return 'Password Must match';
                                return null;
                              }
                            },
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              hintText: 'Enter your Password...',
                              hintStyle: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                                  color: Color(0xFF95A1AC),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF1D2429),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 2),
                          child: TextFormField(
                            controller: confirmPasswordController,
                            onChanged: (password) {
                              onPasswordmat(password, _password!);
                            },
                            onSaved: (text) {
                              _passwordconfirmation = text;
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please put your Password';
                              } else {
                                if (_hasPasswordmatch == false)
                                  return 'Password Must match';
                                return null;
                              }
                            },
                            obscureText: !confirmPasswordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              hintText: 'Enter your Password...',
                              hintStyle: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  24, 24, 20, 24),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => confirmPasswordVisibility =
                                      !confirmPasswordVisibility,
                                ),
                                child: Icon(
                                  confirmPasswordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0xFF95A1AC),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: TextStyle(
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
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _isPasswordEightCharacters
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _isPasswordEightCharacters
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Contains at least 8 characters")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasPasswordOneNumber
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _hasPasswordOneNumber
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Contains at least 1 number")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasPasswordmatch
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _hasPasswordmatch
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Password Must Match")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              _keyForm.currentState!.save();

                              Map<String, dynamic> userData = {
                                "firstName": "Achref",
                                "email": _email,
                                "password": _password,
                              };
                              print(userData);

                              Map<String, String> headers = {
                                "Content-Type":
                                    "application/json; charset=UTF-8"
                              };

                              http
                                  .post(Uri.http(baseUrl, "/createuser"),
                                      headers: headers,
                                      body: json.encode(userData))
                                  .then((http.Response response) async {
                                if (response.statusCode == 200) {
                                  Map<String, dynamic> userData =
                                      json.decode(response.body);

                                  // SharedPreferences
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString("userId", userData["_id"]);

                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          FirstRun(),
                                    ),
                                  );
                                } else if (response.statusCode == 404) {
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
                          },
                          child: Container(
                              width: 170,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF090F13),
                            elevation: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {
                        //     print('Button pressed ...');
                        //   },
                        //   child: Container(
                        //       width: 230,
                        //       height: 50,
                        //       child: Text('Continue as Guest')),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.white,
                        //     textStyle: TextStyle(
                        //       fontFamily: 'Lexend Deca',
                        //       color: Color(0xFF090F13),
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     elevation: 1,
                        //   ),
                        // ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 24, 24, 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                color: Color(0xFFDBE2E7),
                                icon: FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Color(0xFF57636C),
                                  size: 20,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                              IconButton(
                                color: Color(0xFFDBE2E7),
                                icon: FaIcon(
                                  FontAwesomeIcons.apple,
                                  color: Color(0xFF57636C),
                                  size: 20,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                              IconButton(
                                color: Color(0xFFDBE2E7),
                                icon: FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  color: Color(0xFF57636C),
                                  size: 20,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
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
