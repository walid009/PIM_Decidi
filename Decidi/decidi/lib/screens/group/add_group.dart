import 'package:decidi/providers/DataProvider.dart';
import 'package:decidi/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({Key? key, required this.reload}) : super(key: key);
  final Function reload;
  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  late String nameGroup;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomBar(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Add New Group",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: shadowColor,
      ),
      body: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5, top: 5),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  fillColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Group Name :",
                  labelStyle: TextStyle(
                    color: labelColor,
                  ),
                ),
                onSaved: (value) {
                  nameGroup = value!;
                },
                validator: (value) {
                  if (value!.isEmpty || value.length < 1) {
                    return "Group Name required minimum 1 caractere";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBottomBar() {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bottomBarColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: shadowColor.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
          top: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.height * 0.4,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();

                    Map<String, dynamic> groupBody = {
                      'nameGroup': nameGroup,
                    };

                    await Provider.of<DataProvider>(context, listen: false)
                        .addGroup(groupBody);

                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: primary,
                  shadowColor: shadowColor,
                  elevation: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
