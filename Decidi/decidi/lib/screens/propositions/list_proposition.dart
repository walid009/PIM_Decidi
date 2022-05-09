import 'package:decidi/models/proposition.dart';
import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/screens/propositions/add_propsition.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/widgets/proposition_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProposition extends StatefulWidget {
  const ListProposition({Key? key}) : super(key: key);

  @override
  State<ListProposition> createState() => _ListPropositionState();
}

class _ListPropositionState extends State<ListProposition> {
  TextEditingController searchcontroller = TextEditingController();

  List<Proposition> searchpropositions = [];
  List<Proposition> allpropositions = [];

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).fetchPropositions();

//allpropositions = Provider.of<DataProvider>(context, listen: false).listpropositions;
  }

  onSearchTextChanged(String text) async {
    searchpropositions.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    allpropositions.forEach((prop) {
      if (prop.Etablissement.toUpperCase().contains(text.toUpperCase()))
        searchpropositions.add(prop);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    allpropositions = Provider.of<DataProvider>(context).listpropositions;
    print(allpropositions.length);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: primary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddProposition(),
            ),
          );
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                          searchpropositions.clear();
                        });
                      },
                    ),
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            ),
          ),
          /* Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  autofocus: false,
                  controller: searchcontroller,
                  onChanged: onSearchTextChanged,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: InkWell(
                      child: Icon(Icons.cancel, color: primary),
                      onTap: () {
                        setState(() {
                          searchcontroller.text = "";
                        });
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    contentPadding: EdgeInsets.only(
                        left: 26.0, bottom: 8.0, top: 8.0, right: 50.0),
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
          ), */
          searchpropositions.length != 0 || searchcontroller.text.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: searchpropositions.length,
                    itemBuilder: (ctxx, i) => PropositionItem(
                      searchpropositions[i].propositionId,
                      searchpropositions[i].Bac,
                      searchpropositions[i].Code.toString(),
                      searchpropositions[i].Filiere,
                      searchpropositions[i].Universite,
                      searchpropositions[i].Etablissement,
                      searchpropositions[i].Gouvernorat,
                      searchpropositions[i].Criteres,
                      searchpropositions[i].Duree,
                      searchpropositions[i].Score,
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: allpropositions.length,
                    itemBuilder: (ctxx, i) => PropositionItem(
                      allpropositions[i].propositionId,
                      allpropositions[i].Bac,
                      allpropositions[i].Code.toString(),
                      allpropositions[i].Filiere,
                      allpropositions[i].Universite,
                      allpropositions[i].Etablissement,
                      allpropositions[i].Gouvernorat,
                      allpropositions[i].Criteres,
                      allpropositions[i].Duree,
                      allpropositions[i].Score,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
