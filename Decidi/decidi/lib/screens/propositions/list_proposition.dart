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
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchPropositions();
  }

  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final propositions = Provider.of<DataProvider>(context).listpropositions;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: primary,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddProposition(
                reload: reloadPage,
              ),
            ),
          );
        },
      ),
      body: ListView.builder(
        itemCount: propositions.length,
        itemBuilder: (context, index) {
          return PropositionItem(
            propositions[index].propositionAcademicBackground,
            propositions[index].propositionUniversityName,
            propositions[index].propositionDescription,
          );
        },
      ),
    );
  }
}
