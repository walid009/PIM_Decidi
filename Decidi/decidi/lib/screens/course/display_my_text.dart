import 'package:flutter/material.dart';

import '../../utils/first_run_data.dart';
import '../first_run.dart';

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
        title: Text("Note list"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Bac type is :" + widget.type),
            ...widget.bacGradesData.map((element) {
              i++;
              return ListTile(
                trailing: Text(element.toString()),
                title: Text(ScienceMat[i]),
              );
            })
          ],
        ),
      ),
    );
  }
}
