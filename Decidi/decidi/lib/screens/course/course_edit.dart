import 'dart:io';

import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/course.dart';
import '../../utils/constant.dart';
import '../../utils/first_run_data.dart';
import '../first_run/first_run.dart';
import 'course_list.dart';

class EditCourse extends StatefulWidget {
  final Course course;
  const EditCourse(this.course, {Key? key}) : super(key: key);

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  late String title;
  late String type;
  late int capacity;
  late int price;
  late String description;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController titleP = TextEditingController();
  TextEditingController typeP = TextEditingController();
  TextEditingController capacityP = TextEditingController();
  TextEditingController priceP = TextEditingController();
  TextEditingController descriptionP = TextEditingController();

  String imagePath = "asd";
  late File myImagePath;
  String finalText = ' ';
  bool isLoaded = false;

  List<MyData> data = [];
  List<MyData> bacGradesData = [];

  String _dropdownValue = "Info";

  @override
  void initState() {
    super.initState();
    titleP.text = widget.course.courseTitle;
    typeP.text = widget.course.courseType;
    capacityP.text = widget.course.courseCapacity;
    priceP.text = widget.course.coursePrice;
    descriptionP.text = widget.course.courseDescription;
  }

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      print(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomBar(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _formkey.currentState!.reset();
            },
            icon: Icon(Icons.refresh_outlined),
            color: Colors.black,
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Edit Course",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: shadowColor,
      ),
      body: Form(
        key: _formkey, //cle pour affichage controle sasie
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5, top: 5),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  //pickImage();
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            "http://" +
                                baseUrl +
                                "/" +
                                widget.course.courseImage,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleP,
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
                  labelText: "Title",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
                onSaved: (value) {
                  title = value!;
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 2) {
                    return "title required minimum 3 caractere";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: typeP,
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
                  labelText: "Type",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
                onSaved: (value) {
                  type = value!;
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 2) {
                    return "type required minimum 3 caractere";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: capacityP,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Capacity",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
                onSaved: (value) {
                  capacity = int.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "capacity required";
                  } else if (int.tryParse(value) == null) {
                    return "must be a number";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: priceP,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Price",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
                onSaved: (value) {
                  price = int.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "quantity required";
                  } else if (int.tryParse(value) == null) {
                    return "must be a number";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionP,
                cursorColor: Colors.black,
                maxLines: 3,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "description",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
                onSaved: (value) {
                  description = value!;
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "description required minumum of 3 caractere";
                  } else {
                    return null;
                  }
                },
              ),
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
                  print(_dropdownValue.toUpperCase());
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
                  print(widget.course.courseTitle);
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    print("données correcte");

                    // ignore: unused_local_variable
                    Map<String, dynamic> courseBody = {
                      '_id': widget.course.courseId,
                      'title': title,
                      'type': type,
                      'capacity': capacity.toString(),
                      'price': price.toString(),
                      'description': description,
                      'bacType': _dropdownValue.toUpperCase()
                    };

                    await Provider.of<DataProvider>(context, listen: false)
                        .UpdateCourse(courseBody);

                    // await http
                    //     .post(Uri.http(baseUrl, "/createcourse"),
                    //         //headers: headers,
                    //         body: carBody)
                    //     .then((response) {
                    //   print(response.statusCode);
                    //   String message = response.statusCode == 200
                    //       ? "course Added"
                    //       : "Error";
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text("Info"),
                    //         content: Text(message),
                    //       );
                    //     },
                    //   );
                    // });

                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Edit",
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
}
