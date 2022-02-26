import 'package:decidi/providers/DataProvider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'course_list.dart';
import 'k_constant.dart';

// ignore: must_be_immutable
class CourseView extends StatelessWidget {
  late String id;
  late String image;
  late String title;
  late String price;

  CourseView(this.id, this.image, this.title, this.price, {Key? key})
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
                                await Provider.of<DataProvider>(context,
                                        listen: false)
                                    .deleteCourse(id);
                                Navigator.of(context).pop();
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
