import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../root_app.dart';
import 'add_car.dart';
import 'car_view.dart';
import 'k_constant.dart';

class CarList extends StatefulWidget {
  const CarList();
  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  late List<Car> cars = [];
  late Future<bool> fetchedCar;

  Future<bool> fetchCars() async {
    http.Response response = await http.get(Uri.http(baseUrl, "/allcourses"));
    List<dynamic> carsFromServer = json.decode(response.body);
    for (int i = 0; i < carsFromServer.length; i++) {
      print(carsFromServer[i]["_id"].toString());

      print(carsFromServer[i]["title"]);
      print(carsFromServer[i]["description"]);
      cars.add(Car(
          carsFromServer[i]["_id"].toString(),
          "" /*"http://10.0.2.2:8000/images/" + carsFromServer[i]["image"]*/,
          carsFromServer[i]["title"],
          carsFromServer[i]["price"]));
    }
    return true;
  }

  @override
  void initState() {
    fetchedCar = fetchCars();
    super.initState();
    //print(cars.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedCar,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("List Course"),
              ),
              drawer: Drawer(
                child: Column(
                  children: [
                    AppBar(
                      title: const Text("Choose"),
                      automaticallyImplyLeading: false,
                    ),
                    ListTile(
                      title: Row(
                        children: const [
                          Icon(Icons.edit),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Add Course")
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => AddCar(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: const [
                          Icon(Icons.home),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Back Home")
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => RootApp(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  print(cars[index].carId);
                  return CarView(cars[index].carId, cars[index].carImage,
                      cars[index].carMarque, cars[index].carModel + " DT");
                },
              ));
        } else {
          print(baseUrl + " mon url");
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Car {
  late String carId;
  late String carImage;
  late String carMarque;
  late String carModel;

  Car(this.carId, this.carImage, this.carMarque, this.carModel);
}
//on fais ListView.Builder au lieu de ListView car ListView elle affiche tout les element et donc si on a
//bcp d'element il seront charge cela cause des problem de performenance et pour cela on utilist
// ListView.Builder
