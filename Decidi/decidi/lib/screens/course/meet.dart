import 'package:flutter/material.dart';
import 'joinWithCode.dart';
import 'new_meeting.dart';

class Meet extends StatefulWidget {
  const Meet({Key? key}) : super(key: key);

  @override
  _MeetState createState() => _MeetState();
}

class _MeetState extends State<Meet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: const Text(
          "Video Conference Course",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => NewMeeting(),
                ),
              );
              //Get.to(NewMeeting());
            },
            icon: Icon(Icons.add),
            label: Text("New Meeting"),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(350, 30),
              primary: Colors.indigo,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        Divider(
          thickness: 1,
          height: 40,
          indent: 40,
          endIndent: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => JoinWithCode(),
                ),
              );
              //Get.to(JoinWithCode());
            },
            icon: Icon(Icons.margin),
            label: Text("Join with a code"),
            style: OutlinedButton.styleFrom(
              primary: Colors.indigo,
              side: BorderSide(color: Colors.indigo),
              fixedSize: Size(350, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        SizedBox(height: 150),
        Image.network(
            "https://user-images.githubusercontent.com/67534990/127524449-fa11a8eb-473a-4443-962a-07a3e41c71c0.png")
      ]),
    );
  }
}
