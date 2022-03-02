import 'package:flutter/material.dart';

class DetailCourseView extends StatelessWidget {
  late String id;
  late String title;
  late String prix;
  late String image;
  late String description;

  DetailCourseView(
      this.id, this.title, this.prix, this.image, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(0),
            child: Image.network(
              image,
              height: 320,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            title,
            textScaleFactor: 2,
            style: const TextStyle(color: Colors.orange),
          ),
          SizedBox(
            height: 25,
          ),
          Text(prix.toString() + " DT", textScaleFactor: 2),
          SizedBox(
            height: 25,
          ),
          Text(description)
        ],
      ),
    );
  }
}
