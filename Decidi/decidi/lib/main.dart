import 'package:decidi/screens/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Decidi App',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: SignInScreen(),
    );
  }
}
