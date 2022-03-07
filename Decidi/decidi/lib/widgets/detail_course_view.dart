import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

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
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * 0.90,
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
                child: Image.network(
                  "http://" + baseUrl + "/" + image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                getAttribute(Icons.schedule_rounded, labelColor, "12 hours"),
                SizedBox(
                  width: 20,
                ),
                getAttribute(Icons.star, orange, "4.5"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                getAttribute(
                    Icons.reduce_capacity, labelColor, "capacity:" + "32"),
                SizedBox(
                  width: 12,
                ),
                getAttribute(
                    Icons.incomplete_circle, labelColor, "participant:" + "1"),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "About course ",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Text(
                description,
                textAlign: TextAlign.justify,
                style: TextStyle(color: labelColor, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getAttribute(IconData icon, Color color, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: labelColor, fontSize: 13),
        ),
      ],
    );
  }
}
