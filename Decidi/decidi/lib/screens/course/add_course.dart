import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'course_list.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key, required this.reload}) : super(key: key);
  final Function reload;

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  late String title;
  late int capacity;
  late int price;
  late String description;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
          "Add New Course",
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
              Container(
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
                  child: Image.asset(
                    "assets/images/node.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
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
                    color: Colors.black,
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
                    color: Colors.black,
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
                    color: Colors.black,
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
                    color: Colors.black,
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
                    print("données correcte");

                    // ignore: unused_local_variable

                    Map<String, dynamic> carBody = {
                      'title': title,
                      'capacity': capacity.toString(),
                      'price': price.toString(),
                      'description': description,
                      'image':
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Node.js_logo.svg/800px-Node.js_logo.svg.png'
                    };

                    await Provider.of<DataProvider>(context, listen: false)
                        .addCourse(carBody);

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
                  "Add",
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
