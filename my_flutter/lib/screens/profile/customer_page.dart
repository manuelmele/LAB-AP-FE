import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/models/review_model.dart';
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
  List<ReviewModel> reviewData = [];
  double? reviewAvg;
  bool disposed = false;

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

/*
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
  } */
  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  void getReviews() {
    if (initialResults) {
      return; // non può più essere usata in nessun altra funzione, crearne un altra per le average
    }
    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      getUserDataService(jwt).then((userResults) {
        getReviewService(jwt, userResults.email).then((reviewResults) {
          getReviewAverageService(jwt, userResults.email)
              .then((reviewAvgResults) {
            if (!disposed) {
              //remind this mechanism before the set state
              setState(() {
                userData = userResults;
                reviewData = reviewResults;
                reviewAvg = reviewAvgResults;
                initialResults = true;
                print(userData);
                print(reviewData);
                print(reviewAvgResults);
              });
            }
          });
        });
      });
    });
  }

  double reviewUpdate(double? rev) {
    if (rev == null) {
      return 0.0;
    } else {
      return rev;
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera, color: kOrange),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image, color: kOrange),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

//function for the pop up of the info
  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Edit your info:"),
            content: Column(children: [
              Text("Your Name"),
              TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: "Enter your Name"),
              ),
              SizedBox(
                height: 25,
              ),
              Text("Your Surname"),
              TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: "Enter your Surname"),
              ),
              SizedBox(
                height: 25,
              ),
              Text("Your Bio"),
              TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: "Enter your Bio"),
              ),
            ]),
            actions: [
              TextButton(
                onPressed:
                    () {}, //passare la funzione che manda i dati al Back End
                child: Text(
                  "SUBMIT",
                ),
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    //getUserData(); lo metto dentro la funzione dopo
    getReviews();
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
                              onTap: () => {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                ),
                              },
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
                                    onTap: () => {
                                      openDialog(),
                                    },
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
                                rating: reviewUpdate(
                                    reviewAvg), //get the rating from the media form the db, try without the function...
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
                              reviewAvg
                                  .toString(), //DISPLAY THE MEDIA FROM THE BACK END
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
                      maxHeight: 250.0,
                    ),
                    child: ListView.builder(
                      //scroll vertical
                      scrollDirection: Axis.vertical,
                      itemCount: reviewData
                          .length, //number of reviews given to the user, input from the databases
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
                              reviewData[index]
                                  .firstName, //get the user name and surname from the db
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              reviewData[index]
                                  .contentReview, //get the content of the review from the db
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
