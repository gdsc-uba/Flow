import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const primarycolor = Color(0xFF12A4EF);
//const secondarycolor = Color(0xFF40EFB8);
const textcolor = Color(0xFF444444);
const orangecolor = Color(0xFFFFA070);
//const darkbluecolor = Color(0xFF694DE8);
const purplecolor = Color(0xFF7960E2);
const secondarycolor = Color(0xFFF86272);

double screenHeight = MediaQueryData().size.height;
double screenWidth = MediaQueryData().size.width;

/// body font size setter

double bodyFontSizeSetter() {
  double customBodyFontSize;
  if (screenWidth < 800) {
    customBodyFontSize = 14;
  }
  {
    customBodyFontSize = 16;
  }
  return customBodyFontSize;
}

/// end body font size setter

/// header font size setter

double headerFontSizeSetter() {
  double customHeaderFontSize;
  if (screenWidth < 800) {
    customHeaderFontSize = 16;
  }
  {
    customHeaderFontSize = 20;
  }
  return customHeaderFontSize;
}

/// end header font size setter

/////// Custom Body Text Widget  /////////////
class BodyText extends StatelessWidget {
  final String title;
  final color;

  const BodyText({Key key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: bodyFontSizeSetter(),
        color: color,
      ),
    );
  }
}

class BodyTextBold extends StatelessWidget {
  final String title;
  final color;

  const BodyTextBold({Key key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: bodyFontSizeSetter(),
        color: color,
      ),
    );
  }
}

////////////// Custom Headline Text Widget/////////
class HeadlineText extends StatelessWidget {
  final String title;
  final color;

  const HeadlineText({Key key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: headerFontSizeSetter(),
        fontWeight: FontWeight.normal,
        color: color,
      ),
    );
  }
}

class HeadlineTextBold extends StatelessWidget {
  final String title;
  final color;

  const HeadlineTextBold({Key key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: headerFontSizeSetter(),
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
