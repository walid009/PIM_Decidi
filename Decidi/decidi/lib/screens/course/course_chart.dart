import 'package:decidi/models/course.dart';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import '../../utils/constant.dart';
import 'add_course.dart';
import '../../widgets/course_view.dart';

class CourseChart extends StatefulWidget {
  const CourseChart();
  @override
  State<CourseChart> createState() => _CourseChartState();
}

class _CourseChartState extends State<CourseChart> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchCourseStatistique();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final chartsData =
        Provider.of<DataProvider>(context).listStatistiquesCourse;
    return Scaffold(
        body: SfCircularChart(
      title: ChartTitle(text: 'Number Of Participant  \n For Each Course '),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        RadialBarSeries<GDPData, String>(
            dataSource: chartsData,
            xValueMapper: (GDPData data, _) => data.continent,
            yValueMapper: (GDPData data, _) => data.gdp,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
            maximumValue: 50)
      ],
    ));
    /*ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        print(cars[index].courseId);
        return CourseView(
            cars[index],
            cars[index].courseId,
            "http://" + baseUrl + "/" + cars[index].courseImage,
            cars[index].courseTitle,
            cars[index].coursePrice + "DT");
      },
    ));*/
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
