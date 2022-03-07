import 'package:decidi/widgets/admin_home_page_item.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            AdminHomePageItem(
              icon: Icon(
                Icons.menu_book_outlined,
                size: 80,
              ),
              title: "Nbr of Proposition",
              nbr: 2,
            ),
            AdminHomePageItem(
              icon: Icon(
                Icons.supervised_user_circle_outlined,
                size: 80,
              ),
              title: "Nbr of Coaches",
              nbr: 5,
            ),
            AdminHomePageItem(
              icon: Icon(
                Icons.person_outline,
                size: 80,
              ),
              title: "Nbr of Users",
              nbr: 5,
            ),
          ],
        ),
      ),
    );
  }
}
