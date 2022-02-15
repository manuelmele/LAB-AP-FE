import 'package:flutter/material.dart';

//------------------- COLORS --------------------//
//this is the value to modify to change base color of the application
//its an hexadecimal value
const int kBackgroundColorCode = 0xFFfbf8ef;
const int kPrimaryColorCode = 0xFFfe7062;

const kBackground = Color(kBackgroundColorCode);
const kBlue = Color(0xFFb5d9f4);
const kLightGreen = Color(0xFFebf1b2);
const kLightOrange = Color(0xFFecc08a);
const kYellow = Color(0xFFf7e4aa);
const kRed = Color(0xFFC70039);

const kOrange = Color(0xFFe78549);
//const kBluScuro = Color(0xFFfe7062);
const kPurple = Color(0xffA598A6);
const kPrimaryColor = Color(kPrimaryColorCode);
const kGrey = Color(0xFFD8D8D8);

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
const String shortPw = "Error: Json field \"password\" is invalid";
const String notMatchingPw =
    "Error: Json field \"password and confirmPassword\" don't match";
const String invalidEmail = "Error: Json field \"email\" is invalid";
const String invalidName = "Error: Json field \"firstName\" is invalid";
const String invalidSurname = "Error: Json field \"surname\" is invalid";
