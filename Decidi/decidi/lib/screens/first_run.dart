import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import 'course/display_my_text.dart';

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
  var items = ["Info", "Science", "Math", "Tech", "Lettre", "Eco"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.grey,
                child: isLoaded
                    ? Image.file(
                        myImagePath,
                        fit: BoxFit.fill,
                      )
                    : const Text("This is image section "),
              ),
            ),
            TextButton(
              onPressed: () {
                getImageFromGallery();
              },
              child: const Text("Pick Image"),
            ),
            TextButton(
              onPressed: () {
                Future.delayed(const Duration(seconds: 5), () {
                  getText(imagePath);
                });
              },
              child: const Text("get text"),
            ),
            /*Text(
              // ignore: prefer_if_null_operators, unnecessary_null_comparison
              finalText != null ? finalText : "This is my text",
            ),*/
            DropdownButton(
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
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future getText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText _reconizedText =
        await textDetector.processImage(inputImage);

    for (TextBlock block in _reconizedText.blocks) {
      for (TextLine textLine in block.lines) {
        for (TextElement textElement in textLine.elements) {
          setState(() {
            if (textElement.text.length == 5 &&
                textElement.text.contains(",")) {
              var rep = textElement.text.replaceAll(',', '.');
              bacGradesData.add(MyData(x: rep));
            }
            data.add(MyData(x: textElement.text));
            finalText = finalText + " " + textElement.text;
          });
        }

        finalText = finalText + '\n';
      }
    }
    // ignore: avoid_print
    print(bacGradesData);
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            DisplayNotes(bacGradesData, _dropdownValue),
      ),
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
}

class MyData {
  late String x;
  MyData({required this.x});

  @override
  String toString() {
    return x;
  }
}
