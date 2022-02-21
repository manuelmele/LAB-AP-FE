import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wefix/services/user_service.dart';
import '../../../size_config.dart';

class CustomerPage extends StatefulWidget {
  @override
  CustomerPageState createState() => CustomerPageState();
}

class CustomerPageState extends State<CustomerPage> {
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
    getUserData();
    if (userData != null) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //here start the container with the profile image
                Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: 75,
                        backgroundColor: kLightOrange,
                        child: CircleAvatar(
                          backgroundImage:
                              Image.memory(base64Decode(userData!.photoProfile))
                                  .image,

                          //Image.asset(
                          //        "assets/images/parrot_cut.png",
                          //        height: 110,
                          //        fit: BoxFit.scaleDown)
                          //    .image,
                          radius: 70,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              //onTap: () =>
                              //    Navigator.pushNamed(context, EditPhoto.routeName),
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
                    ),
                  ],
                ),

                //here starts the container with the info of the user
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        //width: MediaQuery.of(context).size.width - 222,
                        //height: MediaQuery.of(context).size.height - 550,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userData!.firstName,
                                  //"Name",
                                  style: TextStyle(fontSize: 32),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  userData!.secondName,
                                  //"Surname",
                                  style: TextStyle(fontSize: 32),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    //onTap: () => Navigator.pushNamed(context, routeName), //insert the edit name route
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
                            Text(
                              userData!.userRole,
                              //"User role",
                              style:
                                  TextStyle(fontSize: 19, color: Colors.grey),
                            ),
                            Text(
                              userData!.email,
                              //"Email",
                              style:
                                  TextStyle(fontSize: 19, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              userData!.bio,
                              //"Here goes the bio",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //here insert the rating
                            Column(children: [
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
                            ]),
                            //here insert the rating
                            Text(
                              "4.5", //DISPLAY THE MEDIA FROM THE DB
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ]),

                //here starts the review for the user
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
                  ],
                ),

                //here starts the list of contents of the reviews
                ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: 250.0, //get max height from the db??
                    ),
                    child: ListView.builder(
                      //scroll horizontal
                      scrollDirection: Axis.vertical,
                      itemCount:
                          5, //number of reviews given to the user, input from the databases
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: kLightOrange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(children: [
                            Text(
                              "Worker id:", //get theuser name and surname from the db
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "This user is reliable", //get the content of the review from the db
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ]),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold();
    }
  }
}
