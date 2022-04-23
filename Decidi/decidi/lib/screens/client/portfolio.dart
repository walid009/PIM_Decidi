import 'package:decidi/models/course.dart';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/client/add_certif.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/widgets/imageportfolio_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../utils/constant.dart';
import '../../widgets/course_view.dart';

class PortfolioList extends StatefulWidget {
  final String userId;
  const PortfolioList(this.userId);
  @override
  State<PortfolioList> createState() => _PortfolioListState();
}

class _PortfolioListState extends State<PortfolioList> {
  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false)
        .fetchImagePortfolio(widget.userId);
  }

  void getData() async {}

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<DataProvider>(context).listImages;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBgColor,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Certificat",
            style: TextStyle(
                color: textColor, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: primary,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddCertif(
                  reload: reloadPage,
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) {
            //print(cars[index].imageId);
            return ImageportfolioView(
                cars[index].imageId, cars[index].urlimage, cars[index].title);
          },
        ));
  }
}
