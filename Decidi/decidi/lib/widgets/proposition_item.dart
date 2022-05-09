import 'package:decidi/screens/propositions/update_proposition.dart';
import 'package:flutter/material.dart';
import 'package:decidi/theme/color.dart';

// ignore: must_be_immutable
class PropositionItem extends StatelessWidget {
  PropositionItem(
    this.propositionId,
    this.bac,
    this.code,
    this.filiere,
    this.universite,
    this.etablissement,
    this.gouvernorat,
    this.critaire,
    this.duree,
    this.score,
  );

  late String propositionId;
  late String bac;
  late String code;
  late String filiere;
  late String universite;
  late String etablissement;
  late String gouvernorat;
  late String critaire;
  late String duree;
  late String score;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => UpdateProposition(
                    propositionId: propositionId,
                    bac: bac,
                    code: code,
                    filiere: filiere,
                    universite: universite,
                    etablissement: etablissement,
                    gouvernorat: gouvernorat,
                    critaire: critaire,
                    duree: duree,
                    score: score,
                  ),
                ),
              );
            },
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
                            filiere,
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
                            universite,
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
                            code,
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
