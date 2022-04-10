import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/group/add_group.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/widgets/group_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../utils/constant.dart';
import '../course/add_course.dart';

class GroupList extends StatefulWidget {
  const GroupList();
  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchGroups();
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<DataProvider>(context).listGroup;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: primary,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddGroup(
                  reload: reloadPage,
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return GroupItem(
              groups[index].groupId,
              groups[index].groupName,
            );
          },
        ));
  }
}
