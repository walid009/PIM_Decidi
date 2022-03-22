import 'package:decidi/theme/color.dart';
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
      body: Center(
        child: ListView(children: [
          SizedBox(
            height: 10,
          ),
          Image.network(
              "https://user-images.githubusercontent.com/67534990/127524449-fa11a8eb-473a-4443-962a-07a3e41c71c0.png"),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
            child: SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.height * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => NewMeeting(),
                    ),
                  );
                  //Get.to(NewMeeting());
                },
                child: Text(
                  "New Meeting",
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.height * 0.4,
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
                  primary: primary,
                  side: BorderSide(color: primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
