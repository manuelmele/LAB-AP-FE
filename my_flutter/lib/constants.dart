import 'package:flutter/material.dart';

//this is the value to modify to change base color of the application
//its an hexadecimal value
const int kPrimaryColorCode = 0xFFfe7062;

const kOrange = Color(0xFFfe7062);
const kBluScuro = Color(0xFFfe7062);
const kPrimaryColor = Color(kPrimaryColorCode);
const kGrey = Color(0xFFD8D8D8);

// questa parte di codice serve a convertire il kPrimaryColor scelto in un colore di tipo MaterialColor
// non ho trovato un metodo piu pulito di usare questa mappa
// in ogni situazione in cui serve un materialColor va utilizzata questa costante qui
MaterialColor kPrimaryColor_material =
    MaterialColor(kPrimaryColorCode, colormap);

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


// costanti per le frasi di errore?