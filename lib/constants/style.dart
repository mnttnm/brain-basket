import 'package:flutter/material.dart';

Color light = Color(0xFFF7F8FC);
Color lightGrey = Color(0xFFA4A6B3);
Color dark = Color(0xFF363740);
Color active = Color(0xFF3C19C0);

const Color primaryDark = Color.fromARGB(255, 62, 167, 136);
const Color primaryMedium = Color.fromARGB(255, 99, 196, 169);
const Color primaryLight = Color.fromARGB(255, 136, 225, 202);

const Color secondaryDark = Color.fromARGB(255, 185, 173, 114);
const Color secondaryMedium = Color.fromARGB(255, 217, 207, 158);
const Color secondaryLight = Color.fromARGB(255, 249, 242, 202);

const Color buttonPrimary = Color(0xFF63C4A9);
const Color buttonSecondary = Color(0xFFFFFCE8);


const LinearGradient bckgradnt = LinearGradient(colors: [
  Color(0xffbcd4f4),
  Color(0xffd1d9f0),
  Color(0xffe5dfeb),
  Color(0xfff8e4e7)
]);


// text

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.0;

const String FontNameDefault = 'Poppins';
const String FontNameSecondary = 'Montserrat';

const AppBartextStyle = TextStyle(
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: MediumTextSize,
    color: secondaryMedium);

const Heading1TextStyle = TextStyle(fontFamily: FontNameDefault, color: secondaryDark);

const SubHeadingTextStyle = TextStyle(fontFamily: FontNameSecondary);

const Body1TextStyle = TextStyle(fontFamily: FontNameSecondary);

const SubTitle1TextStyle =
    TextStyle(fontFamily: FontNameSecondary, fontSize: BodyTextSize);
