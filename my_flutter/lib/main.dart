import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/intro/intro.dart';
import 'package:wefix/routes.dart';
import 'package:wefix/screens/navigator/navigator.dart';

import '../../../size_config.dart';

String? jwt;
bool? rememberMe;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  rememberMe = prefs.getBool('rememberMe');
  jwt = prefs.getString('jwt');
  print(rememberMe);
  print(jwt);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeFix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Dosis',
              fontSizeFactor: 1.1,
              fontSizeDelta: 2.0,
            ),
        primarySwatch: kPrimaryColor_material,
      ),
      initialRoute: jwt == null || rememberMe == false
          ? Intro.routeName
          : NavigatorScreen
              .routeName, //Intro.routeName, //this is set to "/intro"
      routes: routes,
    );
  }
}
