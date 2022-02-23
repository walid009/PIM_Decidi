import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'car_list.dart';
import 'k_constant.dart';

// ignore: must_be_immutable
class CarView extends StatelessWidget {
  late String id;
  late String image;
  late String title;
  late String price;

  CarView(this.id, this.image, this.title, this.price, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: InkWell(
          onTap: () async {
            /*Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BookCar(int.parse(id));
          }));*/
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/node.png",
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        Text(price),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: new Text('DELETE'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete"),
                          content: Text(
                              "Are you sure to delete " + title.toString()),
                          actions: [
                            new ElevatedButton(
                              child: new Text('Confirm'),
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () async {
                                await http.delete(
                                    Uri.http(baseUrl, "/deletecourse/" + id));
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        CarList(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
