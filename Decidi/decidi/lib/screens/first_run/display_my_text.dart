import 'package:decidi/screens/root_app.dart';
import 'package:flutter/material.dart';

import '../../utils/first_run_data.dart';
import 'first_run.dart';

class DisplayNotes extends StatefulWidget {
  final List<MyData> bacGradesData;
  final String type;
  const DisplayNotes(this.bacGradesData, this.type, {Key? key})
      : super(key: key);

  @override
  _DisplayNotesState createState() => _DisplayNotesState();
}

class _DisplayNotesState extends State<DisplayNotes> {
  int i = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Degrees list",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text("Bac type is :" + widget.type),
            ...widget.bacGradesData.map((element) {
              i++;
              return ListTile(
                trailing: Text(element.toString()),
                title: getSubjects(widget.type),
              );
            }),
            SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () => Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => RootApp(),
                ),
              ),
              icon: Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }

  getSubjects(type) {
    switch (type) {
      case "Info":
        {
          return Text(InfoMat[i]);
        }

      case "Science":
        {
          return Text(ScienceMat[i]);
        }

      case "Math":
        {
          return Text(MathMat[i]);
        }
      case "Tech":
        {
          return Text(TechMat[i]);
        }

      case "Lettre":
        {
          return Text(LettreMat[i]);
        }

      case "Eco":
        {
          return Text(EcoMat[i]);
        }
      default:
        {
          return Text("SportMat[i]");
        }
    }
  }
}
