import 'package:decidi/screens/propositions/add_propsition.dart';
import 'package:decidi/theme/color.dart';
import 'package:decidi/widgets/proposition_item.dart';
import 'package:flutter/material.dart';

class ListProposition extends StatefulWidget {
  const ListProposition({Key? key}) : super(key: key);

  @override
  State<ListProposition> createState() => _ListPropositionState();
}

class _ListPropositionState extends State<ListProposition> {
  void reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          PropositionItem(data: null),
        ],
      ),
    );
  }
}
