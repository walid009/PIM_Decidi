import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/widgets/custom_image.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../screens/course/course_list.dart';

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
      child: InkWell(
        onTap: () async {
          /*Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BookCar(int.parse(id));
          }));*/
        },
        child: Container(
          //width: MediaQuery.of(context).size.height * 0.4,
          height: 280,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5, top: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              CustomImage(
                image,
                width: double.infinity,
                height: 190,
                radius: 15,
              ),
              Positioned(
                top: 210,
                right: 15,
                child: GestureDetector(
                  onTap: () {
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
                                    ElevatedButton.styleFrom(primary: primary),
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
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor.withOpacity(0.05),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child:
                              Icon(Icons.delete_outline, color: Colors.white),
                        ),
                        TextSpan(
                          text: "Delete",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 210,
                child: Container(
                  width: 250,
                  padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 17,
                            color: textColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        price,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
