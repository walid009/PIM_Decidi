import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/propositions/add_propsition.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/widgets/proposition_item.dart';
import 'package:decidi/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchUserscUsers();
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<DataProvider>(context).listUsersUser;

    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserItem(
            users[index].id,
            users[index].role,
            users[index].firstName,
            users[index].email,
          );
        },
      ),
    );
  }
}
