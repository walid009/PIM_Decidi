import 'package:flutter/material.dart';
import 'package:decidi/theme/color.dart';

class PropositionItem extends StatelessWidget {
  PropositionItem(
      this.academicBackground, this.universityName, this.description,
      {Key? key})
      : super(key: key);

  late String academicBackground;
  late String universityName;
  late String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.95,
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
                child: Row(
                  children: [
                    new Container(
                      child: Text(""),
                      height: 90,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Text(
                            academicBackground,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            universityName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, color: textColor),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, color: labelColor),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
