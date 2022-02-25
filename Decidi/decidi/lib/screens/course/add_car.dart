import 'package:decidi/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'car_list.dart';
import 'k_constant.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key, required this.reload}) : super(key: key);
  final Function reload;

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  late String title;
  late int capacity;
  late int price;
  late String description;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Add New Course",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formkey, //cle pour affichage controle sasie
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Image.asset(
                "assets/images/course.png",
                height: 200,
                width: 370,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "title"),
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
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Capacity"),
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Price"),
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
              maxLines: 3,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "description"),
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
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
                              'image': 'bmw.jpg'
                            };

                            await Provider.of<DataProvider>(context,
                                    listen: false)
                                .addCar(carBody);

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
                        child: const Text(
                          "Add",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20)))
                        //const Text("Add", textScaleFactor: 1.5)
                        ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _formkey.currentState!.reset();
                        },
                        child: const Text("clear"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20)))
                        //style: ElevatedButton.styleFrom(fixedSize: const Size(80, 80), primary: Colors.red)
                        ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
