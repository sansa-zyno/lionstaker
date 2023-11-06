import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/screens/add_tips.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/widgets/main_ui.dart';

class DashBoard extends StatefulWidget {
  String username;
  DashBoard({Key? key, required this.username}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  ScrollController? scrollController;
  int i = 5;
  bool showmore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.mainContext = context;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List items = ["assets/ls_ad.jpg", "assets/ls_ad.jpg", "assets/ls_ad.jpg"];
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return appProvider.feeds != null
        ? appProvider.feeds!.isNotEmpty
            ? Column(children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        //border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10.0,
                              offset: Offset(2, 2),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          readOnly: true,
                          onTap: () {
                            /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => AddPostPage()));*/
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                    backgroundColor: Colors.blueGrey[100],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    insetPadding: EdgeInsets.all(8),
                                    contentPadding: EdgeInsets.all(15),
                                    content: AddPostPage()));
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefix: Text("   "),
                            hintText: "Enter Betslip Code",
                            prefixIconConstraints: BoxConstraints(
                                maxHeight: 35,
                                minHeight: 35,
                                maxWidth: 35,
                                minWidth: 35),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: CircleAvatar(
                                  backgroundColor: buttoncolor,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  )),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                  onTap: () {
                                    /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => AddPostPage()));*/
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                            backgroundColor:
                                                Colors.blueGrey[100],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            insetPadding: EdgeInsets.all(8),
                                            contentPadding: EdgeInsets.all(15),
                                            content: AddPostPage()));
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: buttoncolor,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ))),
                            ),
                            suffixIconConstraints: BoxConstraints(
                                maxHeight: 35,
                                minHeight: 35,
                                maxWidth: 35,
                                minWidth: 35),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        height: 100,
                        disableCenter: true,
                        viewportFraction: 1),
                    items: items
                        .map(
                          (item) => Image.asset(
                            item,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    //controller: scrollController,
                    physics: ClampingScrollPhysics(),
                    itemCount: appProvider.feeds!.take(i).toList().length + 1,
                    itemBuilder: (ctx, index) {
                      return index !=
                              (appProvider.feeds!.take(i).toList().length)
                          ? MainUi(
                              data: appProvider.feeds![index],
                              username: widget.username,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Center(
                                child: InkWell(
                                    onTap: () {
                                      i += 5;
                                      setState(() {});
                                    },
                                    child: Text("Show more",
                                        style: TextStyle(color: mycolor))),
                              ));
                    },
                  ),
                ),
              ])
            : Center(child: Text("No data to show"))
        : Center(
            child: CircularProgressIndicator(
            color: buttoncolor,
          ));
  }
}
