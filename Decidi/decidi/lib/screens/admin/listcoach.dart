import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/propositions/add_propsition.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/widgets/proposition_item.dart';
import 'package:decidi/widgets/user_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCoachs extends StatefulWidget {
  const ListCoachs({Key? key}) : super(key: key);

  @override
  State<ListCoachs> createState() => _ListCoachsState();
}

class _ListCoachsState extends State<ListCoachs> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchUserscCoach();
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final coachs = Provider.of<DataProvider>(context).listUsersCoach;

    return Scaffold(
      body: ListView.builder(
        itemCount: coachs.length,
        itemBuilder: (context, index) {
          return UserItem(
            coachs[index].id,
            coachs[index].role,
            coachs[index].firstName,
            coachs[index].email,
          );
        },
      ),
    );
  }
}
