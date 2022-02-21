import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../size_config.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      backgroundImage: Image.asset(
                              "assets/images/parrot_cut.png", // caricare l'immagine del database
                              height: 110,
                              fit: BoxFit.scaleDown)
                          .image,
                      radius: 70,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () =>
                              {}, //connect directly to the imagepicker function
                          //see laura code
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
                              "Name",
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
                            "Profession",
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
                          "Brief description or presentation of the worker (info from the db)",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
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
                      ],
                    ),
                  ),
                ],
              ),

              //starts the gallery
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Gallery",
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
                      //onTap: () => {}, //show dialog for adding photos to the gallery
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
              //here starts the list of images
              ConstrainedBox(
                  constraints: new BoxConstraints(
                    maxHeight: 100.0,
                  ),
                  child: ListView.builder(
                    //scroll horizontal
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        18, //number of photos uploaded by the user, input from the databases
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 35, horizontal: 35),
                        decoration: BoxDecoration(
                            color: kLightOrange,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: const AssetImage(
                                  "assets/images/parrot_cut.png"),
                              //take the image input from the database
                              fit: BoxFit.scaleDown,
                            )),
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
                            EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                        decoration: BoxDecoration(
                            color: kLightOrange,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kOrange,
                                  borderRadius: BorderRadius.circular(16)),
                              //child:
                              //Image.asset("assets/images/parrot_cut.png") useful i I want to import an image
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 2 - 100,
                              child: Text(
                                "First element, Price:...",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
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
