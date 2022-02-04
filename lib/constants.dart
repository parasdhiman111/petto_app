import 'package:flutter/material.dart';

const Map<int, Color> primaryColorSwatch =
{
  50:Color.fromRGBO(0,74,173, .1),
  100:Color.fromRGBO(0,74,173, .2),
  200:Color.fromRGBO(0,74,173, .3),
  300:Color.fromRGBO(0,74,173, .4),
  400:Color.fromRGBO(0,74,173, .5),
  500:Color.fromRGBO(0,74,173, .6),
  600:Color.fromRGBO(0,74,173, .7),
  700:Color.fromRGBO(0,74,173, .8),
  800:Color.fromRGBO(0,74,173, .9),
  900:Color.fromRGBO(0,74,173, 1),
};

const Map<int, Color> accentColorSwatch =
{
  50:Color.fromRGBO(255,97,0, .1),
  100:Color.fromRGBO(255,97,0, .2),
  200:Color.fromRGBO(255,97,0, .3),
  300:Color.fromRGBO(255,97,0, .4),
  400:Color.fromRGBO(255,97,0, .5),
  500:Color.fromRGBO(255,97,0, .6),
  600:Color.fromRGBO(255,97,0, .7),
  700:Color.fromRGBO(255,97,0, .8),
  800:Color.fromRGBO(255,97,0, .9),
  900:Color.fromRGBO(255,97,0, 1),
};



const primaryColor=const MaterialColor(0xff004aad,primaryColorSwatch);
const accentColor=const MaterialColor(0xffff6100,accentColorSwatch);

const SERVICE_URL="https://petto-backend.herokuapp.com";