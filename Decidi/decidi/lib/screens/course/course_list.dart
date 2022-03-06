import 'package:decidi/models/course.dart';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'add_course.dart';
import 'course_view.dart';

class CourseList extends StatefulWidget {
  const CourseList();
  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchCourse();
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<DataProvider>(context).listCourse;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: primary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddCourse(
                reload: reloadPage,
              ),
            ),
          );
        },
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          print(cars[index].courseId);
          return CourseView(cars[index].courseId, cars[index].courseImage,
              cars[index].courseTitle, cars[index].coursePrice + "DT");
        },
      ),
    );
  }
}
