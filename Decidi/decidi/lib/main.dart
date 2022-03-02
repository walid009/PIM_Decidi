import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Decidi App',
          theme: ThemeData(
            primaryColor: primary,
          ),
          home: SignInScreen()
          // HomePage()

          ///ExplorePage(),

          //  FirstRun(),
          ),
    );
  }
}
