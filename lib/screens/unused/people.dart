/*import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import '../constants/api.dart';

class People extends StatefulWidget {
  const People({Key? key}) : super(key: key);

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  List? people;
  Future getData(username) async {
    final res = await HttpService.get("");
    print(res.data);
    people = jsonDecode(res.data);
    log(people.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData("username");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        toolbarHeight: appBarHeight,
        flexibleSpace: Row(
          children: [
            Container(
              decoration: BoxDecoration(),
              child: Image.asset(
                "assets/lstk4.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: people != null
          ? people!.isNotEmpty
              ? ListView.builder(
                  itemCount: people!.length,
                  itemBuilder: (ctx, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            backgroundImage: NetworkImage(
                              "http://xixira.com/sites/ask/${people![index]["ProfileImage"]}",
                            ),
                            radius: 30,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${people![index]["LastName"]} ${people![index]["FirstName"]}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.verified_sharp,
                                color: mycolor,
                              )
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("${people![index]["username"]}"),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Rating:"),
                                      Text("${people![index]["Rating"]}")
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: mycolor),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add, color: mycolor),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "follow",
                                      style: TextStyle(color: mycolor),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                      ))
              : Center(child: Text("No data to show"))
          : Center(child: CircularProgressIndicator()),
    );
  }
}*/
