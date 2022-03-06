import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';

class AdminHomePageItem extends StatelessWidget {
  const AdminHomePageItem(
      {Key? key, required this.icon, required this.title, required this.nbr})
      : super(key: key);

  final Icon icon;
  final String title;
  final int nbr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          icon,
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500, color: labelColor),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            nbr.toString(),
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w800, color: red),
          ),
        ],
      ),
    );
  }
}
