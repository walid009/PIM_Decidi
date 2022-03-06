import 'dart:io';

import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProposition extends StatefulWidget {
  final String propositionId;
  final String academicBackground;
  final String universityName;
  final String description;

  const UpdateProposition(
      {Key? key,
      required this.propositionId,
      required this.academicBackground,
      required this.universityName,
      required this.description})
      : super(key: key);

  @override
  State<UpdateProposition> createState() => _UpdatePropositionState();
}

class _UpdatePropositionState extends State<UpdateProposition> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String imagePath = "asd";
  late File myImagePath;
  bool isLoaded = false;

  late String academicBackgroundF;
  late String universityNameF;
  late String descriptionF;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomBar(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Delete"),
                      content:
                          Text("Are you sure to delete this proposition ??"),
                      actions: [
                        new ElevatedButton(
                          child: new Text('Confirm'),
                          style: ElevatedButton.styleFrom(primary: primary),
                          onPressed: () async {
                            await Provider.of<DataProvider>(context,
                                    listen: false)
                                .deleteProposition(widget.propositionId);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(Icons.delete_outlined),
            color: Colors.black,
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Update Proposition",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: shadowColor,
      ),
      body: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5, top: 5),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  getImageFromGallery();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: isLoaded
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.file(
                            myImagePath,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Center(
                          child: const Text("Click here and choose an image")),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.academicBackground,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Academic background :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
                onSaved: (value) {
                  academicBackgroundF = value!;
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return "title required minimum 10 caractere";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: widget.universityName,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "University Name :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
                onSaved: (value) {
                  universityNameF = value!;
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return "university Name required minimum 10 caractere";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: widget.description,
                maxLines: 8,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Description :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
                onSaved: (value) {
                  descriptionF = value!;
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return "title required minimum 10 caractere";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
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
              height: 45,
              width: MediaQuery.of(context).size.height * 0.4,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();

                    Map<String, dynamic> propositionBody = {
                      '_id': widget.propositionId,
                      'academicBackground': academicBackgroundF,
                      'universityName': universityNameF,
                      'description': descriptionF,
                    };
                    await Provider.of<DataProvider>(context, listen: false)
                        .updateProposition(propositionBody);

                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Update",
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
          ],
        ),
      ),
    );
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
