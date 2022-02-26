import 'package:decidi/screens/SignInScreen.dart';
import 'package:decidi/screens/course/course_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  late int current_index = 0;
  final List<Widget> interfaces = const [
    CourseList(),
    CourseList(),
    CourseList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Course",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        // shadowColor: Colors.black,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              title: const Text(
                "List Course",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.power_settings_new),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Se deconnecter")
                ],
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("userId");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SignInScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: interfaces[current_index],
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.article), label: "Courses"),
            BottomNavigationBarItem(
                icon: Icon(Icons.article), label: "Proposals"),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: "Groups")
          ],
          currentIndex: current_index,
          onTap: (value) {
            setState(() {
              current_index = value;
            });
            // print(current_index);
          }),
    );
  }
}
