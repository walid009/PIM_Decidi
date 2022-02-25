import 'package:decidi/screens/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../car_list.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  late int current_index = 0;
  final List<Widget> interfaces = const [CarList(), CarList(), CarList()];

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
                  Icon(Icons.edit),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Modifier profil")
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home/updateUser");
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.tab),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Navigation par onglet")
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home/navTab");
              },
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "store"),
            BottomNavigationBarItem(
                icon: Icon(Icons.article), label: "bibliotheque"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_rounded), label: "panier")
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
