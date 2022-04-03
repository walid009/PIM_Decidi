import 'package:decidi/models/group.dart';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/widgets/group_item.dart';
import 'package:flutter/material.dart';
import 'package:decidi/utils/data.dart';
import 'package:decidi/widgets/chat_item.dart';
import 'package:decidi/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<DataProvider>(context).listGroup;
    return buildBody(groups);
  }

  buildBody(List<Group> groups) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(children: [
        getHeader(),
        getChats(groups),
      ]),
    );
  }

  getHeader() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Groups",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomTextBox(
              hint: "Search",
              prefix: Icon(Icons.search, color: Colors.grey),
            ),
          ],
        ));
  }

  getChats(List<Group> groups) {
    return ListView(
        padding: EdgeInsets.only(
          top: 10,
        ),
        shrinkWrap: true,
        children: List.generate(
            groups.length,
            (index) => GroupItem(
                  groups[index].groupId,
                  groups[index].groupName,
                )));
  }
}
