import 'package:decidi/theme/color.dart';
import 'package:decidi/utils/data.dart';
import 'package:decidi/widgets/category_rectangle.dart';
import 'package:decidi/widgets/custom_textfield.dart';
import 'package:decidi/widgets/feature_item.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  buildBody() {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getHeader(),
              getBody(),
              getFeature(),
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
            CustomTextBox(
              hint: "Search",
              prefix: Icon(Icons.search, color: Colors.grey),
            ),
          ],
        ));
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
                  )))),
    );
  }

  getFeature() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          features.length,
          (index) => FeatureItem(
            onTap: () {},
            data: features[index],
          ),
        ),
      ),
    );
  }
}
