import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/services/user_service.dart';

import '../../../size_config.dart';

class WorkerPage extends StatefulWidget {
  @override
  WorkerPageState createState() => WorkerPageState();
}

class WorkerPageState extends State<WorkerPage> {
  String? jwt;
  UserModel? userData;
  bool initialResults = false;

  void getUserData() {
    //search by category just the first time
    if (initialResults) return;

    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      getUserDataService(jwt).then((newResults) {
        setState(() {
          userData = newResults;
          initialResults = true;
          print(userData);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserData(); // when the page starts it calls the user data
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: kLightOrange,
                    child: CircleAvatar(
                      backgroundImage:
                          Image.memory(base64Decode(userData!.photoProfile))
                              .image,

                      //Image.asset(
                      //      "assets/images/parrot_cut.png", // caricare l'immagine del database
                      //    height: 110,
                      //  fit: BoxFit.scaleDown)
                      //.image,
                      radius: 70,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () =>
                              {}, //connect directly to the imagepicker function

                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: kLightOrange,
                            child: Icon(
                              Icons.edit,
                              color: kWhite,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 222,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              userData!.firstName,
                              style: TextStyle(fontSize: 32),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () => {}, //show dialog for modify name
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: kLightOrange,
                                  child: Icon(
                                    Icons.edit,
                                    color: kWhite,
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(children: [
                          Text(
                            userData!.category,
                            style: TextStyle(fontSize: 19, color: Colors.grey),
                          ),
                          //here insert the rating!!!!
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                              height: 5,
                            ),
                          ],
                        ),
                        Text(
                          userData!.bio,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),

                        //here starts the rating
                        Row(children: [
                          RatingBarIndicator(
                            rating:
                                4.5, //get the rating from the media form the db
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 30.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "4.5", //DISPLAY THE MEDIA FROM THE DB
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),

              //starts the slides containers with the reviews
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Reviews",
                    style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //here starts the list of contents reviews
              ConstrainedBox(
                  constraints: new BoxConstraints(
                    maxHeight: 100.0, //get max height from the db??
                  ),
                  child: ListView.builder(
                    //scroll horizontal
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        18, //number of reviews given to the user, input from the databases
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: kLightOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(children: [
                          Text(
                            "User id1:", //get theuser name and surname from the db
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Example of review 1", //get the content of the review from the db
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ]),
                      );
                    },
                  )),
              SizedBox(
                height: 5,
              ),
              //here starts the price list code
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Price List",
                    style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      //onTap: () => {}, //show dialog function for adding price list item
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: kLightOrange,
                        child: Icon(
                          Icons.edit,
                          color: kWhite,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              //here starts the list of items
              ConstrainedBox(
                  constraints: new BoxConstraints(
                    maxHeight: 200.0,
                  ),
                  child: ListView.builder(
                    //controller: controller, doesn't work fine
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: 4, //number of photos uploaded by the user
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                            color: kLightOrange,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(60),
                              decoration: BoxDecoration(
                                  color: kOrange,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: const AssetImage(
                                        "assets/images/parrot_cut.png"),
                                    //take the image input from the database
                                    fit: BoxFit.fitHeight,
                                  )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              child: Column(children: [
                                Text(
                                  "Title", // import from the db
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  "Description:...", // import from the db
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                                Text(
                                  "Price:...", // import from the db
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                              ]),
                            )
                          ],
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
