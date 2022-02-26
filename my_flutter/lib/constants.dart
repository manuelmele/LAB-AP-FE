import 'package:flutter/material.dart';

//------------------- BASE URLs --------------------//
//String BASE_URL = '10.0.2.2:8000'; //indirizzo per emulatore
//String BASE_URL = '192.168.1.9:8000'; //indirizzo IP laura
//String BASE_URL = '192.168.1.239:8000'; //indirizzo IP daniela
String BASE_URL = '192.168.1.53:8000'; //indirizzo IP manuel

//------------------- COLORS --------------------//
//this is the value to modify to change base color of the application
//its an hexadecimal value
const int kBackgroundColorCode = 0xFFfbf8ef;
const int kPrimaryColorCode = 0xFFfe7062;

const kBackground = Color(kBackgroundColorCode);
const kBlue = Color(0xFF8fb2d0);
const kLightBlue = Color(0xFFb5d9f4);
const kLightGreen = Color(0xFFcfdc9e);
const kLightOrange = Color(0xFFecc08a);
const kYellow = Color(0xFFf7e4aa);
const kRed = Color(0xFFC70039);
const kBlueDark = Color(0xFF6397d0);

const kOrange = Color(0xFFe78549);
//const kBluScuro = Color(0xFFfe7062);
const kPurple = Color(0xffa598a6);
const kPrimaryColor = Color(kPrimaryColorCode);
const kGrey = Color(0xFF888888);
const kWhite = Color(0xffFFFFFF);

// questa parte di codice serve a convertire il kPrimaryColor scelto in un colore di tipo MaterialColor
// non ho trovato un metodo piu pulito di usare questa mappa
// in ogni situazione in cui serve un materialColor va utilizzata questa costante qui
MaterialColor kPrimaryColor_material = MaterialColor(0xFFe78549, colormap);

Map<int, Color> colormap = {
  50: Color.fromRGBO(147, 205, 72, .1),
  100: Color.fromRGBO(147, 205, 72, .2),
  200: Color.fromRGBO(147, 205, 72, .3),
  300: Color.fromRGBO(147, 205, 72, .4),
  400: Color.fromRGBO(147, 205, 72, .5),
  500: Color.fromRGBO(147, 205, 72, .6),
  600: Color.fromRGBO(147, 205, 72, .7),
  700: Color.fromRGBO(147, 205, 72, .8),
  800: Color.fromRGBO(147, 205, 72, .9),
  900: Color.fromRGBO(147, 205, 72, 1),
};

//--------------------- ERRORS -----------------------//
//per la login
const String wrong = "Error: Invalid username o password";

//per la signup
const String mandatory = "* Required field";
const String usedEmail = "Error: Email already used";
//----------errori che mario deve specificare nel backend
const String shortPw = "Error: Weak password";
const String notMatchingPw = "Error: Passwords don't match";
const String invalidEmail = "Error: Invalid email";
const String invalidName = "Error: Json field 'firstName' is invalid";
const String invalidSurname = "Error: Json field 'surname' is invalid";
//per la signupOptional
const String imageTooBig = "Error: Image should have maximum size 30KB";
const String invalidBio = "Error: Invalid bio";
//per il change password
const String invalidOldPw = "Error: Invalid old password";
const String invalidNewPw = "Error: Invalid new password";
//per il forgot password
const String invalidUsername = "Error: Invalid username";
