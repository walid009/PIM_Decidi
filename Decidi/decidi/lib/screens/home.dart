import 'package:carousel_slider/carousel_slider.dart';
import 'package:decidi/models/proposition.dart';
import 'package:decidi/models/user.dart';
import 'package:decidi/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/utils/data.dart';
import 'package:decidi/widgets/category_box.dart';
import 'package:decidi/widgets/feature_item.dart';
import 'package:decidi/widgets/notification_box.dart';
import 'package:decidi/widgets/recommend_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/course.dart';
import '../providers/DataProvider.dart';
import 'course/detail_course.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchPropositionsByBac();
    Provider.of<DataProvider>(context, listen: false).fetchCourseParBacType();
    user = Provider.of<DataProvider>(context, listen: false).user;
  }

  @override
  Widget build(BuildContext context) {
    final listcourses = Provider.of<DataProvider>(context).listCourseParBacTyoe;
    return Scaffold(
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: getAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => buildBody(listcourses),
                childCount: 1,
              ),
            )
          ],
        ));
  }

  Widget getAppBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.firstName,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Good Morning!",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
            ],
          )),
          NotificationBox(
            notifiedNumber: 1,
            onTap: () {},
          )
        ],
      ),
    );
  }

  buildBody(List<Course> listcourses) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          getCategories(),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Text("Featured",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                )),
          ),
          getFeature(listcourses),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: darker),
                ),
              ],
            ),
          ),
          //getRecommend(),
        ]),
      ),
    );
  }

  int selectedCollection = 0;
  getCategories() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              categories.length,
              (index) => Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CategoryBox(
                    selectedColor: Colors.white,
                    data: categories[index],
                    onTap: () {
                      setState(() {
                        selectedCollection = index;
                      });
                    },
                  )))),
    );
  }

  getFeature(List<Course> listcourses) {
    return CarouselSlider(
        options: CarouselOptions(
          height: 290,
          enlargeCenterPage: true,
          disableCenter: true,
          viewportFraction: .75,
        ),
        items: List.generate(
            listcourses.length,
            (index) => FeatureItem(
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
                  image: "http://" +
                      baseUrl +
                      "/" +
                      listcourses[index].courseImage,
                  title: listcourses[index].courseTitle,
                  capacity: listcourses[index].courseCapacity,
                  nbParticipant: listcourses[index]
                      .courseListParticipants
                      .length
                      .toString(),
                  price: listcourses[index].coursePrice,
                  description: listcourses[index].courseDescription,
                )));
  }

  getRecommend() {
    final listprops =
        Provider.of<DataProvider>(context).listpropositionsBacType;
    List<Proposition> propAI = [];
    if (listprops.isNotEmpty)
      propAI.add(listprops.firstWhere((p) => p.Code == user.codeAI));

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          propAI.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: RecommendItem(
              data: propAI[index],
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
