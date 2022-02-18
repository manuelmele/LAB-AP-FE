import 'package:flutter/material.dart';
import 'package:wefix/screens/homepage/home_page.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountEmail: Text("kalpesh.khandla@bosc.in"),
            accountName: Text("Kalpesh Khandla"),
            currentAccountPicture: CircleAvatar(
              child: Text("KK"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              print("Home Clicked");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
