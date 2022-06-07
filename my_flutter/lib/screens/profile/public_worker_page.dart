import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wefix/models/product_model.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wefix/models/review_model.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/screens/payment/payment.dart';
import 'package:wefix/services/user_service.dart';
import 'package:wefix/services/worker_services.dart';

import '../../../size_config.dart';
import '../book_appointment/booking.dart';

class PublicWorkerPage extends StatefulWidget {
  static String routeName = "/publicWorker";
  @override
  PublicWorkerPageState createState() => PublicWorkerPageState();
}

class PublicWorkerPageState extends State<PublicWorkerPage> {
  String? jwt;
  UserModel? workerData;
  bool initialResults = false;
  List<ReviewModel> reviewData = [];
  List<ProductModel> productData = [];
  bool disposed = false;
  String? emailWorker;

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  void setEmailWorker() async {
    SharedPreferences.getInstance().then((prefs) {
      emailWorker = prefs.getString('emailWorker')!;
    });
    print(emailWorker);
  }

  void getInfo() {
    if (initialResults) {
      return; // non può più essere usata in nessun altra funzione, crearne un altra per le average
    }
    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      emailWorker = prefs.getString('emailWorker')!;
      getPublicWorkerDataService(jwt, emailWorker!).then((workerResults) {
        getPublicWorkerReviewService(jwt, emailWorker!).then((reviewResults) {
          getPublicWorkerProductService(jwt, emailWorker!)
              .then((productResults) {
            if (!disposed) {
              //remind this mechanism before the set state
              setState(() {
                workerData = workerResults;
                reviewData = reviewResults;
                productData = productResults;
                initialResults = true;
                print(workerData);
                print(reviewData);
                print(productData);
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

  @override
  Widget build(BuildContext context) {
    getInfo(); // when the page starts it calls the user data
    if (workerData != null) {
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
                            Image.memory(base64Decode(workerData!.photoProfile))
                                .image,
                        radius: 70,
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
                                (workerData!.firstName +
                                                " " +
                                                workerData!.secondName)
                                            .length >
                                        10
                                    ? (workerData!.firstName +
                                                " " +
                                                workerData!.secondName)
                                            .substring(0, 10) +
                                        "..."
                                    : workerData!.firstName +
                                        " " +
                                        workerData!.secondName,
                                //"Name",
                                style: TextStyle(fontSize: 32),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // Text(
                              //   workerData!.secondName,
                              //   //"Surname",
                              //   style: TextStyle(fontSize: 32),
                              // ),
                            ],
                          ),
                          Row(children: [
                            Text(
                              workerData!.category,
                              style:
                                  TextStyle(fontSize: 19, color: Colors.grey),
                            ),
                          ]),
                          // Row(
                          //   children: [
                          //     SizedBox(
                          //       height: 5,
                          //     ),
                          //     Text(
                          //       workerData!.email,
                          //       //"Email",
                          //       style:
                          //           TextStyle(fontSize: 19, color: Colors.grey),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            workerData!.bio.length > 60
                                ? workerData!.bio.substring(0, 60) + "..."
                                : workerData!.bio,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),

                          //here starts the rating
                          Row(children: [
                            RatingBarIndicator(
                              rating: workerData!
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
                              workerData!.avgStar
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
                    child: (reviewData.length == 0)
                        ? Text("No reviews yet...")
                        : ListView.builder(
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
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
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                //here starts the list of items
                ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: SizeConfig.screenHeight / (2.5).toDouble(),
                    ),
                    child: ListView.builder(
                      //controller: controller, doesn't work fine
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: productData
                          .length, //number of products uploaded by the user
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
                                      image: Image.memory(base64Decode(
                                              productData[index].image))
                                          .image,
                                      //"assets/images/parrot_cut.png"
                                      //take the image input from the database
                                      fit: BoxFit.fitHeight,
                                    )),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 10,
                                child: Column(children: [
                                  Text(
                                    productData[index].title,
                                    //"Title", // import from the db
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    productData[index].description,
                                    //"Description:...", // import from the db
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                  Text(
                                    productData[index].price.toString(),
                                    //"Price:...", // import from the db
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext ctx) =>
                        BookAppointmentPage(emailWorker: workerData!.email))),
          }, // here I invoke the function to book the appointment, go to another page
          backgroundColor: kOrange,
          child: Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Scaffold();
    }
  }
}
