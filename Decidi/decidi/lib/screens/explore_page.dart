import 'package:decidi/models/course.dart';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/course/detail_course.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/utils/constant.dart';
import 'package:decidi/utils/data.dart';
import 'package:decidi/widgets/category_rectangle.dart';
import 'package:decidi/widgets/custom_textfield.dart';
import 'package:decidi/widgets/explore_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  TextEditingController searchcontroller = TextEditingController();

  List<Course> searchcourses = [];
  List<Course> allcourses = [];

  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchCourse();
  }

  onSearchTextChanged(String text) async {
    searchcourses.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    allcourses.forEach((prop) {
      if (prop.courseTitle.toUpperCase().contains(text.toUpperCase()))
        searchcourses.add(prop);
    });

    setState(() {});
  }

  Widget build(BuildContext context) {
    return buildBody();
  }

  buildBody() {
    allcourses = Provider.of<DataProvider>(context).listCourse;

    return Scaffold(
      backgroundColor: appBgColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(children: [
          getHeader(),
          //getBody(),
          searchcourses.length != 0 || searchcontroller.text.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: searchcourses.length,
                    itemBuilder: (ctxx, i) => ExploreItem(
                      onTap: () {
                        print(searchcourses.length);
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                DetailCourse(searchcourses[i].courseId),
                          ),
                        );
                      },
                      id: searchcourses[i].courseId,
                      image: "http://" +
                          baseUrl +
                          "/" +
                          searchcourses[i].courseImage,
                      title: searchcourses[i].courseTitle,
                      capacity: searchcourses[i].courseCapacity,
                      nbParticipant: searchcourses[i]
                          .courseListParticipants
                          .length
                          .toString(),
                      price: searchcourses[i].coursePrice,
                      description: searchcourses[i].courseDescription,
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: allcourses.length,
                    itemBuilder: (ctxx, i) => ExploreItem(
                      onTap: () {
                        print(allcourses.length);
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                DetailCourse(allcourses[i].courseId),
                          ),
                        );
                      },
                      id: allcourses[i].courseId,
                      image:
                          "http://" + baseUrl + "/" + allcourses[i].courseImage,
                      title: allcourses[i].courseTitle,
                      capacity: allcourses[i].courseCapacity,
                      nbParticipant: allcourses[i]
                          .courseListParticipants
                          .length
                          .toString(),
                      price: allcourses[i].coursePrice,
                      description: allcourses[i].courseDescription,
                    ),
                  ),
                ),
        ]),
      ),
    );
  }

  getHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Explore",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 3),
              height: 40,
              decoration: BoxDecoration(
                color: textBoxColor,
                border: Border.all(color: textBoxColor),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.05),
                    spreadRadius: .5,
                    blurRadius: .5,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                autofocus: false,
                controller: searchcontroller,
                onChanged: onSearchTextChanged,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    suffixIcon: InkWell(
                      child: Icon(Icons.cancel, color: primary),
                      onTap: () {
                        setState(() {
                          searchcontroller.text = "";
                          searchcourses.clear();
                        });
                      },
                    ),
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCategories(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  int selectedCollection = 0;
  bool isSelected = false;
  getCategories() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CategoryRectangle(
              selectedColor: primary,
              data: categories[index],
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  selectedCollection = index;
                  print(selectedCollection);
                  isSelected = !isSelected;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  getFeature(List<Course> listcourses) {
    return List.generate(
      listcourses.length,
      (index) => ExploreItem(
        onTap: () {
          print(listcourses.length);
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  DetailCourse(listcourses[index].courseId),
            ),
          );
        },
        id: listcourses[index].courseId,
        image: "http://" + baseUrl + "/" + listcourses[index].courseImage,
        title: listcourses[index].courseTitle,
        capacity: listcourses[index].courseCapacity,
        nbParticipant:
            listcourses[index].courseListParticipants.length.toString(),
        price: listcourses[index].coursePrice,
        description: listcourses[index].courseDescription,
      ),
    );
  }
}
