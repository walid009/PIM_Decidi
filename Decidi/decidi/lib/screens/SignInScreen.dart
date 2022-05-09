import 'dart:convert';

import 'package:decidi/models/user.dart';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/SignUpScreen.dart';
import 'package:decidi/screens/admin/dashboard_admin.dart';
import 'package:decidi/screens/course/organisateur/NavigationBottom.dart';
import 'package:decidi/screens/forgetpage.dart';
import 'package:decidi/screens/root_app.dart';
import 'package:decidi/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'course/organisateur/NavigationBottom.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'first_run/first_run.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:decidi/models/user.dart' as AppUser;

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;
  late bool passwordVisibility;
  late String? _email;
  late GoogleSignInAccount? googleuserr;
  late String? _password;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleuser!.authentication;
    googleuserr = googleuser;
    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    Fluttertoast.showToast(msg: "Account created");

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;
    return Scaffold(
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
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 140,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                ),
                                alignment: const AlignmentDirectional(-1, 0),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF090F13),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 140,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF1F4F8),
                                ),
                                alignment: const AlignmentDirectional(-1, 0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF95A1AC),
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
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
                                return 'Please put your Password';
                              }
                              return null;
                            },
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              hintText: 'Enter your Password...',
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

                              Map<String, dynamic> userData = {
                                "email": _email,
                                "password": _password,
                              };
                              print(userData);

                              Map<String, String> headers = {
                                "Content-Type":
                                    "application/json; charset=UTF-8"
                              };

                              http
                                  .post(Uri.http(baseUrl, "/loginClient"),
                                      headers: headers,
                                      body: json.encode(userData))
                                  .then((http.Response response) async {
                                if (response.statusCode == 200) {
                                  Map<String, dynamic> userData =
                                      json.decode(response.body);

                                  AppUser.User user = AppUser.User(
                                      userData["id"],
                                      userData["firstName"],
                                      "lastName",
                                      userData["email"],
                                      userData["role"],
                                      userData["bacType"],
                                      userData["codeAI"]);
                                  Provider.of<DataProvider>(context,
                                          listen: false)
                                      .setUser(user);

                                  // SharedPreferences
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString("userId", userData["id"]);
                                  prefs.setString(
                                      "userEmail", userData["email"]);
                                  if (userData["role"] == "client") {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            RootApp(),
                                      ),
                                    );
                                  } else if (userData["role"] == "admin") {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            DashboardAdmin(),
                                      ),
                                    );
                                  } else if (userData["role"] == "coach") {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            NavigationBottom(),
                                      ),
                                    );
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            RootApp(),
                                      ),
                                    );
                                  }
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
                          },
                          child: Container(
                              width: 150,
                              height: 50,
                              child: Center(
                                  child: Text(
                                'Login',
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    ForgetScreen(),
                              ),
                            );
                          },
                          child: Text("Forget password? click here")),
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
                        //       color: const Color(0xFF090F13),
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     elevation: 1,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 24, 24, 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Color(0xFF57636C),
                                  size: 20,
                                ),
                                onPressed: () async {
                                  signInWithGoogle();
                                  print(
                                      "///////////////////////////////////////////////");
                                  print(googleuserr!.email);

                                  Map<String, dynamic> userData = {
                                    "firstName": googleuserr!.displayName,
                                    "email": googleuserr!.email,
                                    "password": "password",
                                    // "role": "client"
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
                                      prefs.setString(
                                          "userId", userData["_id"]);

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              RootApp(),
                                        ),
                                      );
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: const FaIcon(
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
                                icon: const FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  color: Color(0xFF57636C),
                                  size: 20,
                                ),
                                onPressed: () async {
                                  final LoginResult result = await FacebookAuth
                                      .instance
                                      .login(permissions: [
                                    "email",
                                    "public_profile"
                                  ]);
                                  if (result.status == LoginStatus.success) {
                                    // you are logged

                                    final AccessToken accessToken =
                                        result.accessToken!;
                                    String url =
                                        "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}";
                                    Uri myUri = Uri.parse(url);
                                    var graphResponse = await http.get(myUri);

                                    var profile =
                                        json.decode(graphResponse.body);
                                    Map<String, dynamic> userData = {
                                      "firstName": profile["first_name"],
                                      "lastName": profile["last_name"],
                                      "email": profile["email"],
                                      "password": "password",
                                      // "role": "client"
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
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            "userId", userData["_id"]);

                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                RootApp(),
                                          ),
                                        );
                                      }
                                    });
                                  } else {
                                    print(result.status);
                                    print(result.message);
                                  }
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
