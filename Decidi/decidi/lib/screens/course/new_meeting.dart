import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:decidi/screens/course/video_call.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';

import 'call.dart';

class NewMeeting extends StatefulWidget {
  NewMeeting({Key? key}) : super(key: key);

  @override
  _NewMeetingState createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  String _meetingCode = "abcdfgqw";

  @override
  void initState() {
    var uuid = Uuid();
    _meetingCode = uuid.v1().substring(0, 8);
    super.initState();
  }

  ClientRole? _role = ClientRole.Broadcaster;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                  child: Icon(Icons.arrow_back_outlined, size: 35),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),
            SizedBox(height: 50),
            Image.network(
              "https://user-images.githubusercontent.com/67534990/127776392-8ef4de2d-2fd8-4b5a-b98b-ea343b19c03e.png",
              fit: BoxFit.cover,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              "Enter meeting code below",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.link),
                    title: SelectableText(
                      _meetingCode,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    trailing: Icon(Icons.copy),
                  )),
            ),
            Divider(thickness: 1, height: 40, indent: 20, endIndent: 20),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.height * 0.55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Share.share("Meeting Code : $_meetingCode");
                },
                icon: Icon(Icons.arrow_drop_down),
                label: Text("Share invite"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: primary,
                  shadowColor: shadowColor,
                  elevation: 1.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.height * 0.55,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await _handleCameraAndMic(Permission.camera);
                  await _handleCameraAndMic(Permission.microphone);
                  // push video page with given channel name
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallPage(
                        channelName: _meetingCode.trim(),
                        role: _role,
                      ),
                    ),
                  );

                  /*Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        VideoCall(channelName: _meetingCode.trim()),
                  ),
                );*/
                  //Get.to(VideoCall(channelName: _meetingCode.trim()));
                },
                icon: Icon(Icons.video_call),
                label: Text("start call"),
                style: OutlinedButton.styleFrom(
                  primary: primary,
                  side: BorderSide(color: primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
