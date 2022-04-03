import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:decidi/screens/course/video_call.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'call.dart';

class JoinWithCode extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
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
              "https://user-images.githubusercontent.com/67534990/127776450-6c7a9470-d4e2-4780-ab10-143f5f86a26e.png",
              fit: BoxFit.cover,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              "Enter meeting code below",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Example : abc-efg-dhi"),
                ),
              ),
            ),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.height * 0.55,
              child: ElevatedButton(
                onPressed: () async {
                  // update input validation
                  // await for camera and mic permissions before pushing video page
                  await _handleCameraAndMic(Permission.camera);
                  await _handleCameraAndMic(Permission.microphone);
                  // push video page with given channel name
                  if (_controller.text.trim().isEmpty) {
                    print("empty");
                  } else {
                    print(_controller.text.trim());
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallPage(
                          channelName: _controller.text.trim(),
                          role: _role,
                        ),
                      ),
                    );
                  }
                  /*Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        VideoCall(channelName: _controller.text.trim()),
                  ),
                );*/
                  //Get.to(VideoCall(channelName: _controller.text.trim()));
                },
                child: Text("Join"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: primary,
                  shadowColor: shadowColor,
                  elevation: 1.0,
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
