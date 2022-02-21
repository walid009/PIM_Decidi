import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'k_constant.dart';

class BookCar extends StatefulWidget {
  static const String id = "idBookCar";
  final int idCar;


  const BookCar(this.idCar, {Key? key}) : super(key: key);

  @override
  State<BookCar> createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  late Future<bool> fetchedCar;
  late Car car;

  Future<bool> fetchCar() async {
    http.Response response = await http.get(Uri.parse(baseUrl+"/car/"+widget.idCar.toString()));
    //http.Response response = await http.get(Uri.http(baseUrl, "/car/getAll"));
    Map<String ,dynamic> carsFromServer = json.decode(response.body);
    car = Car(
          "http://10.0.2.2:8000/images/"+carsFromServer["image"],
          carsFromServer["marque"],
          carsFromServer["model"],
          carsFromServer["description"],
          int.parse(carsFromServer["quantity"].toString())
      );
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchedCar = fetchCar();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedCar,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Scaffold(
                appBar: AppBar(
                    title: const Text("Book a Car")
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(car.carImage),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(car.carMarque+" "+car.carModel)
                    ),
                    const Text("description : "),
                    Text(car.description),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text("quantity "+car.quantity.toString())
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          http.patch(
                            Uri.parse(baseUrl+"/car/update/"+widget.idCar.toString())
                          ).then((response) {
                            if(response.statusCode == 200){
                              http.get(Uri.parse(baseUrl+"/car/"+widget.idCar.toString())).then((response){
                                Map<String ,dynamic> carsFromServer = json.decode(response.body);
                                car = Car(
                                    "http://10.0.2.2:8000/images/"+carsFromServer["image"],
                                    carsFromServer["marque"],
                                    carsFromServer["model"],
                                    carsFromServer["description"],
                                    int.parse(carsFromServer["quantity"].toString())
                                );
                                setState(() {
                                });
                              });
                            }else{
                              print("error server : "+response.statusCode.toString());
                            }
                          });
                        },
                        child: const Text("Book New Car"),
                      ),
                    )
                  ],
                )
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
    );
  }
}

class Car {
  late String carImage;
  late String carMarque;
  late String carModel;
  late String description;
  late int quantity;

  Car(this.carImage, this.carMarque, this.carModel, this.description,
      this.quantity);
}
