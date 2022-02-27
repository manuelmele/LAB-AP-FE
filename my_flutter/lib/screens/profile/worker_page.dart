import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wefix/models/review_model.dart';
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
  List<ReviewModel> reviewData = [];
  bool disposed = false;
  List<String?> errors = [];
  String? newName;
  String? newSurname;
  String? newBio;

  XFile? _photoProfile;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void getInfo() {
    if (initialResults) {
      return; // non può più essere usata in nessun altra funzione, crearne un altra per le average
    }
    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      getUserDataService(jwt).then((userResults) {
        getReviewService(jwt).then((reviewResults) {
          if (!disposed) {
            //remind this mechanism before the set state
            setState(() {
              userData = userResults;
              reviewData = reviewResults;
              initialResults = true;
              print(userData);
              print(reviewData);
            });
          }
        });
      });
    });
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
              onPressed: () async {
                SharedPreferences.getInstance().then((prefs) async {
                  String jwt = prefs.getString('jwt')!;
                  takePhoto(ImageSource.camera);

                  String response =
                      await updatePhotoService(jwt, _photoProfile);

                  //to refresh the information of the user
                  initialResults = false;
                  getInfo();

                  if (response.contains('Error')) {
                    String error = response;
                    addError(error: error);
                  } else {
                    print('all ok');
                    return;
                  }
                });
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image, color: kOrange),
              onPressed: () async {
                SharedPreferences.getInstance().then((prefs) async {
                  String jwt = prefs.getString('jwt')!;
                  takePhoto(ImageSource.gallery);

                  String response =
                      await updatePhotoService(jwt, _photoProfile);

                  //to refresh the information of the user
                  initialResults = false;
                  getInfo();

                  if (response.contains('Error')) {
                    String error = response;
                    addError(error: error);
                  } else {
                    print('all ok');
                    return;
                  }
                });
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
      _photoProfile = pickedFile; // modify! invoke the function on the backend
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> editUserSettings(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          //bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return //SingleChildScrollView(child:
                AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      TextFormField(
                        initialValue: userData!.firstName,
                        onSaved: (newValue) => newName = newValue,
                        onChanged: (value) {
                          setState(() {
                            newName = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return mandatory;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kLightOrange),
                          ),

                          labelText: "Your Name",
                          //focusColor: kOrange,
                          hintText: "Enter your name",
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      TextFormField(
                        initialValue: userData!.secondName,
                        onSaved: (newValue) => newSurname = newValue,
                        onChanged: (value) {
                          setState(() {
                            newSurname =
                                value; //switcha tra password oscurata e password visibile
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return mandatory;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kLightOrange),
                          ),

                          labelText: "Your Surname",
                          //focusColor: kOrange,
                          hintText: "Enter your surname",
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(
                            Icons.person,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      TextFormField(
                        initialValue: userData!.bio,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        onSaved: (newValue) => newBio = newValue,
                        onChanged: (value) {
                          setState(() {
                            newBio = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return mandatory;
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: BorderSide(color: kLightOrange),
                          ),

                          labelText: "Your Bio",
                          //focusColor: kOrange,
                          hintText: "Enter your bio",
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(
                            Icons.library_books,
                          ),
                        ),
                      ),
                    ],
                  )),
              title: Text('Edit your info:'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? jwt = prefs.getString('jwt');

                    print("Adesso stampo la jwt");
                    print(jwt);

                    //check, the values cannot be null
                    if (newName == null) {
                      newName = userData!.firstName;
                    }
                    if (newSurname == null) {
                      newSurname = userData!.secondName;
                    }
                    if (newBio == null) {
                      newBio = userData!.bio;
                    }
                    String res = await updateProfileService(
                        jwt!, newName!, newSurname!, newBio!);
                    print(res);
                    //chiamo la funzione validate per mostrare gli errori a schermo
                    if (!_formKey.currentState!.validate()) {
                      print("not valid");
                    }
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                      initialResults = false;
                      getInfo();
                    }
                  },
                ),
              ],
              //),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    getInfo(); // when the page starts it calls the user data
    if (userData != null) {
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
                        radius: 70,
                        child: Container(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () => {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              ),
                            }, //connect directly to the imagepicker function

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
                                  onTap: () async => {
                                    await editUserSettings(context),
                                  }, //show dialog for modify name
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
                              style:
                                  TextStyle(fontSize: 19, color: Colors.grey),
                            ),
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
                              rating: userData!
                                  .avgStar, //get the rating from the media form the db
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
                              userData!.avgStar
                                  .toString(), //DISPLAY THE MEDIA FROM THE DB
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
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
                                  .firstName, //get theuser name and surname from the db
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
                        onTap: () =>
                            {}, //show dialog function for adding price list item
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
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
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
                                width:
                                    MediaQuery.of(context).size.width / 2 - 30,
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
    } else {
      return Scaffold();
    }
  }
}
