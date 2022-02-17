import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:wefix/screens/profile/edit_photo.dart';

import '../../../size_config.dart';

class ProfilePageBasic extends StatefulWidget {
  @override
  ProfilePageStateBasic createState() => ProfilePageStateBasic();
}

class ProfilePageStateBasic extends State<ProfilePageBasic> {
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
                              "assets/images/parrot_cut.png",
                              height: 110,
                              fit: BoxFit.scaleDown)
                          .image,
                      radius: 70,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          // doesn't change the edit button, good
                          onTap: () =>
                              Navigator.pushNamed(context, EditPhoto.routeName),
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
                        //Text(
                        //  "Profession",
                        //  style: TextStyle(fontSize: 19, color: Colors.grey),
                        //),
                        Text(
                          "Email",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        //spostare l'about in un altro container
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "About",
                              style: TextStyle(fontSize: 22),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                //onTap: () => Navigator.pushNamed(context, routeName), //insert the edit bio route
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: kLightOrange,
                                  child: Icon(
                                    Icons.edit,
                                    color: kWhite,
                                    size: 17,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Brief description or presentation of the worker (info from the db)",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //insert bottone "passa a pro"

              //insert container for rating

              //insert container for reviews

              SizedBox(
                height: 5,
              ),
              //here starts the list of items

              //button for the log out
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    alignment: Alignment.center,
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('jwt');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => LoginScreen()));
                  },
                  child: Text('Logout', textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
