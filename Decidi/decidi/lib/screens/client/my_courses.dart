import 'package:decidi/models/course.dart';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../utils/constant.dart';
import '../../widgets/course_view.dart';
import '../../widgets/my_course_view.dart';

class MyCourses extends StatefulWidget {
  final String email;
  const MyCourses(this.email);
  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false)
        .fetchMyCourse(widget.email);
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<DataProvider>(context).listOfMyCourse;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBgColor,
          foregroundColor: Colors.black,
          title: Text(
            "My Courses",
            style: TextStyle(
                color: textColor, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) {
            print(cars[index].courseId);
            return MyCourseView(
                cars[index].courseId,
                "http://" + baseUrl + "/" + cars[index].courseImage,
                cars[index].courseTitle,
                cars[index].coursePrice + "DT");
          },
        ));
  }
}
