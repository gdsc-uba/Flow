import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class FlowSnackBar extends StatelessWidget {
  final String text;

  const FlowSnackBar({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //width: double.infinity,
      // elevation: 0,
      duration: Duration(milliseconds: 300),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      content: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: BodyText(
          title: text,
          color: primarycolor,
        ),
      ),
      backgroundColor: Colors.white,
    )) as Widget;
    // return SnackBar(
    //   content: Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(10),
    //         topRight: Radius.circular(10),
    //       ),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(16),
    //       child: BodyText(
    //         title: text,
    //         color: primarycolor,
    //       ),
    //     ),
    //   ),
    //   backgroundColor: Colors.transparent,
    // );
  }
}
