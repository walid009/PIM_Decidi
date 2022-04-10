import 'package:decidi/screens/SignInScreen.dart';
import 'package:decidi/screens/course/course_list.dart';
import 'package:decidi/screens/group/group_list.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  // late int current_index = 0;
  // final List<Widget> interfaces = const [
  //   CourseList(),
  //   CourseList(),
  //   CourseList()
  // ];

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
                        "Courses",
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
                        "Groups",
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
            "Coach Dashboard",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
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
              icon: Icon(Icons.logout_outlined),
            )
          ],
          // shadowColor: Colors.black,
        ),
        //body: interfaces[current_index],
        body: TabBarView(children: [
          CourseList(),
          GroupList(),
        ]),
        // bottomNavigationBar: BottomNavigationBar(
        //     items: const [
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.article), label: "Courses"),
        //       BottomNavigationBarItem(icon: Icon(Icons.article), label: "Groups")
        //     ],
        //     currentIndex: current_index,
        //     onTap: (value) {
        //       setState(() {
        //         current_index = value;
        //       });
        //       // print(current_index);
        //     }),
      ),
    );
  }
}
