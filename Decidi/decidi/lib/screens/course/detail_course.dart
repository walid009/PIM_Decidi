import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../providers/DataProvider.dart';
import '../../theme/color.dart';
import '../../utils/constant.dart';
import 'detail_course_view.dart';

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
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  title: Center(child: const Text("Details"))),
              body: DetailCourseView(choix.id, choix.title, choix.prix,
                  choix.image, choix.description),
              floatingActionButton: FloatingActionButton.extended(
                icon: Icon(Icons.shopping_cart),
                label: Text("Participate"),
                backgroundColor: primary,
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
              ));
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
}

class Course2 {
  late String id;
  late String title;
  late String prix;
  late String image;
  late String description;
  Course2(this.id, this.title, this.prix, this.image, this.description);
}
