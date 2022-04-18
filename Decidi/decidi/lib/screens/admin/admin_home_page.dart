import 'package:decidi/widgets/admin_home_page_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/DataProvider.dart';
import '../propositions/list_proposition.dart';
import 'listcoach.dart';
import 'listusers.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DataProvider>(context, listen: false).fetchPropositions();
    Provider.of<DataProvider>(context, listen: false).fetchUsers();
    Provider.of<DataProvider>(context, listen: false).fetchUserscCoach();
    Provider.of<DataProvider>(context, listen: false).fetchUserscUsers();
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<DataProvider>(context).listUsers;
    final usersUser = Provider.of<DataProvider>(context).listUsersUser;
    final usersCoach = Provider.of<DataProvider>(context).listUsersCoach;
    final propositions = Provider.of<DataProvider>(context).listpropositions;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              child: AdminHomePageItem(
                icon: Icon(
                  Icons.menu_book_outlined,
                  size: 80,
                ),
                title: "Nbr of Proposition",
                nbr: propositions.length,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ListProposition(),
                  ),
                );
              },
            ),
            GestureDetector(
              child: AdminHomePageItem(
                icon: Icon(
                  Icons.supervised_user_circle_outlined,
                  size: 80,
                ),
                title: "Nbr of Coaches",
                nbr: usersCoach.length,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ListCoachs(),
                  ),
                );
              },
            ),
            GestureDetector(
              child: AdminHomePageItem(
                icon: Icon(
                  Icons.person_outline,
                  size: 80,
                ),
                title: "Nbr of Users",
                nbr: usersUser.length,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ListUsers(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
