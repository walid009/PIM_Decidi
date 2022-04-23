import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageList extends StatefulWidget {
  final String idGroup;
  MessageList(this.idGroup);
  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false)
        .fetchMessages(widget.idGroup);
    getuserid();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String description;

  late String userid;

  TextEditingController msgController = TextEditingController();

  void getuserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("userId")!;
  }

  Widget getBottomBar() {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bottomBarColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: shadowColor.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
          top: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.height * 0.4,
              child: Row(
                children: [
                  Form(
                    key: _formkey,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 5, top: 5),
                      width: 220,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        controller: msgController,
                        decoration: const InputDecoration(
                          fillColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          labelText: "Message :",
                          labelStyle: TextStyle(
                            color: labelColor,
                          ),
                        ),
                        onSaved: (value) {
                          description = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 1) {
                            return "message required minimum 1 caractere";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();

                        Map<String, dynamic> msgBody = {
                          'idSender': userid,
                          'description': description,
                          'idGroup': widget.idGroup
                        };

                        await Provider.of<DataProvider>(context, listen: false)
                            .addMsg(msgBody, widget.idGroup);
                        setState(() {
                          msgController.text = "";
                        });
                      }
                    },
                    child: Text(
                      "Send",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: primary,
                      shadowColor: shadowColor,
                      elevation: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final msgs = Provider.of<DataProvider>(context).listMsg;
    return Scaffold(
        bottomNavigationBar: getBottomBar(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Chat",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 2.0,
          shadowColor: shadowColor,
        ),
        body: ListView.builder(
          itemCount: msgs.length,
          itemBuilder: (context, index) {
            return MsgItem(
              msgs[index].msgId,
              msgs[index].description,
            );
          },
        ));
  }
}
