import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile Page"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset("assets/images/parrot_cut.png",
                      height: 110,
                      fit: BoxFit
                          .fitHeight), // overflowed - need to redemension the image!!
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
                        Text(
                          "Nome",
                          style: TextStyle(fontSize: 32),
                        ),
                        Text(
                          "Professione",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        Text(
                          "Zona di lavoro",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        Text(
                          "...Altre informazioni...",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        Text(
                          "About",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          "Brief description or presentation of the worker",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Gallery",
                style: TextStyle(
                    color: Color(0xff242424),
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
              ConstrainedBox(
                  constraints: new BoxConstraints(
                    maxHeight: 100.0,
                  ),
                  child: ListView.builder(
                    //scroll horizontal
                    scrollDirection: Axis.horizontal,
                    itemCount: 18, //number of photos uploaded by the user
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                        decoration: BoxDecoration(
                            color: kPurple,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: const AssetImage(
                                  "assets/images/parrot_cut.png"),
                              fit: BoxFit.fill,
                            )),
                      );
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Price List",
                style: TextStyle(
                    color: Color(0xff242424),
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 22,
              ),
              ConstrainedBox(
                  constraints: new BoxConstraints(
                    maxHeight: 100.0,
                  ),
                  child: ListView.builder(
                    //controller: controller, doesn't work fine
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: 2, //number of photos uploaded by the user
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                        decoration: BoxDecoration(
                            color: kPurple,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(0xffBBBBBB),
                                  borderRadius: BorderRadius.circular(16)),
                              //child:
                              //Image.asset("assets/images/parrot_cut.png")
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 2 - 130,
                              child: Text(
                                "First element, Price:...",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
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
