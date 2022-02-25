import 'package:decidi/models/course.dart';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'add_car.dart';
import 'car_view.dart';
import 'k_constant.dart';

class CarList extends StatefulWidget {
  const CarList();
  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchCars();
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<DataProvider>(context).cars;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "List Course",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: primary,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddCar(
                  reload: reloadPage,
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) {
            print(cars[index].carId);
            return CarView(cars[index].carId, cars[index].carImage,
                cars[index].carMarque, cars[index].carModel + " DT");
          },
        ));
  }
}
