import 'package:decidi/screens/SignInScreen.dart';
import 'package:decidi/screens/admin/admin_home_page.dart';
import 'package:decidi/screens/propositions/list_proposition.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({Key? key}) : super(key: key);

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  final bool isSelected = false;
  final Color selectedColor = actionColor;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: new PreferredSize(
            preferredSize:
                new Size(MediaQuery.of(context).size.width * 0.8, 50),
            child: new Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TabBar(
                tabs: [
                  Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Home",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: labelColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Propositions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: labelColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
                indicatorColor: primary,
                labelColor: Colors.black,
                indicatorWeight: 2,
              ),
            ),
          ),
          elevation: 2.0,
          title: const Text(
            "Dashboard",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("userId");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SignInScreen(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                "assets/icons/logout.svg",
                color: isSelected ? selectedColor : textColor,
                width: 30,
                height: 30,
              ),
            )
          ],
          // shadowColor: Colors.black,
        ),
        body: TabBarView(children: [
          AdminHomePage(),
          ListProposition(),
        ]),
      ),
    );
  }
}
