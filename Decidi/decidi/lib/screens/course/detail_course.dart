import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../providers/DataProvider.dart';
import '../../theme/color.dart';
import '../../utils/constant.dart';
import '../../widgets/detail_course_view.dart';

class DetailCourse extends StatefulWidget {
  final String idCourse;

  const DetailCourse(this.idCourse, {Key? key}) : super(key: key);
  @override
  _DetailCourseState createState() => _DetailCourseState();
}

class _DetailCourseState extends State<DetailCourse> {
  static final String tokenizationKey = 'sandbox_f252zhq7_hh4cpc39zq4rgjcg';
  late Course2 choix;
  late Future<bool> fetchedMenu;

  late String? username;

  Future<bool> fetchChoixMenu() async {
    // http.Response response = await http.get(Uri.parse(baseUrl + "/getcourse/62139b08a609499e8edb406e"));

    http.Response response = await http
        .get(Uri.http(baseUrl, "/getcourse/" + widget.idCourse.toString()));

    Map<String, dynamic> choixpaysFromServer = json.decode(response.body);
    print(choixpaysFromServer["_id"]);
    choix = Course2(
      choixpaysFromServer["_id"],
      choixpaysFromServer["title"],
      choixpaysFromServer["type"],
      choixpaysFromServer["price"],
      choixpaysFromServer["image"],
      choixpaysFromServer["description"],
    );
    print(choix);
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchedMenu = fetchChoixMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedMenu,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            bottomNavigationBar: getBottomBar(),
            appBar: AppBar(
                elevation: 2.0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                title: const Text("Details")),
            body: DetailCourseView(choix.id, choix.title, choix.type,
                choix.prix, choix.image, choix.description),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void showNonce(BraintreePaymentMethodNonce nonce) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Payment method nonce:'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Nonce: ${nonce.nonce}'),
            SizedBox(height: 16),
            Text('Type label: ${nonce.typeLabel}'),
            SizedBox(height: 16),
            Text('Description: ${nonce.description}'),
          ],
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
          right: 10,
          left: 10,
          bottom: 15,
          top: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                height: 45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price ",
                      style: TextStyle(
                        color: labelColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      choix.prix + " DT",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    http.Response response = await http.get(Uri.http(
                        baseUrl,
                        "/checkuserparticipateorno/" +
                            choix.id +
                            "/" +
                            prefs.getString("userEmail").toString()));
                    Map<String, dynamic> carsFromServer =
                        json.decode(response.body);
                    bool test = carsFromServer["exist"];
                    print(test);

                    if (test == true) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(
                                  "You'are already participate to this course"),
                            );
                          });
                    } else {
                      final request = BraintreePayPalRequest(
                        amount: choix.prix,
                      );
                      final result = await Braintree.requestPaypalNonce(
                        tokenizationKey,
                        request,
                      );
                      if (result != null) {
                        await Provider.of<DataProvider>(context, listen: false)
                            .participateToCourse(choix.id);
                        showNonce(result);
                      }
                    }
                  },
                  child: Text(
                    "Participate",
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
            ),
          ],
        ),
      ),
    );
  }
}

class Course2 {
  late String id;
  late String title;
  late String type;
  late String prix;
  late String image;
  late String description;
  Course2(
      this.id, this.title, this.type, this.prix, this.image, this.description);
}
