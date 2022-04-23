import 'dart:io';

import 'package:decidi/screens/first_run/display_my_text_Info.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/utils/first_run_data.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import 'display_my_text.dart';

class FirstRun extends StatefulWidget {
  const FirstRun({Key? key}) : super(key: key);

  @override
  _FirstRunState createState() => _FirstRunState();
}

class _FirstRunState extends State<FirstRun> {
  String imagePath = "asd";
  late File myImagePath;
  String finalText = ' ';
  bool isLoaded = false;

  List<MyData> data = [];
  List<MyData> bacGradesData = [];

  String _dropdownValue = "Info";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getHeader(),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 5, top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        getImageFromGallery();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: shadowColor.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        //color: Colors.grey,
                        child: isLoaded
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.file(
                                  myImagePath,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Center(
                                child: const Text(
                                    "Click here and select your diploma degree")),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DropdownButton(
                          items: items.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _dropdownValue = newValue!;
                            });
                          },
                          value: _dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: secondary),
                          underline: Container(
                            height: 2,
                            color: secondary,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            primary: primary,
                            shadowColor: shadowColor,
                            elevation: 1.0,
                          ),
                          onPressed: () {
                            // ignore: unrelated_type_equality_checks
                            if (imagePath == "asd") {
                              showAlertDialog(context);
                            } else {
                              getText(imagePath);
                            }
                          },
                          child: const Text(
                            "get text",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getText(String path) async {
    bacGradesData.clear();
    final inputImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText _reconizedText =
        await textDetector.processImage(inputImage);

    for (TextBlock block in _reconizedText.blocks) {
      for (TextLine textLine in block.lines) {
        for (TextElement textElement in textLine.elements) {
          setState(() {
            if (textElement.text.length == 5 &&
                (textElement.text.contains(",") ||
                    textElement.text.contains("."))) {
              var rep = textElement.text.replaceAll(',', '.');
              bacGradesData.add(MyData(x: rep));
            }
            data.add(MyData(x: textElement.text));
            finalText = finalText + " " + textElement.text;
            print(finalText);
          });
        }

        finalText = finalText + '\n';
      }
    }
    // ignore: avoid_print
    print(bacGradesData);
    Navigator.of(context).push<void>(MaterialPageRoute<void>(
      builder: (BuildContext context) =>
          DisplayNotes(bacGradesData, _dropdownValue),
    )
        //DisplayMyTextInfo(bacGradesData, _dropdownValue)),
        );
    // print(data.toString());
  }

  // this is for getting the image form the gallery
  void getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      myImagePath = File(image!.path);
      isLoaded = true;
      imagePath = image.path.toString();
    });
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
                        "Bac information",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
            SizedBox(height: 15),
          ],
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        primary: primary,
        shadowColor: shadowColor,
        elevation: 1.0,
      ),
      child: Text(
        "OK",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => Navigator.pop(context),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Please choose a diploma degrees to scan."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class MyData {
  late String x;
  MyData({required this.x});

  @override
  String toString() {
    return x;
  }
}
