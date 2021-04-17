import 'package:flow/Components/flow_location.dart';
import 'package:flow/constants.dart';
import 'package:flutter/material.dart';

class FlowAskPermissions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: purplecolor,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * .2),
                child: Image(
                  image:
                      AssetImage('Assets/images/placeholder_image_white.png'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
                child: HeadlineTextBold(
                    title: 'Allow Flow to access your location?',
                    color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),

          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            // ignore: deprecated_member_use
            child: FlatButton(
              child: HeadlineTextBold(
                title: 'Allow Permissions',
                color: primarycolor,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // ignore: deprecated_member_use
          FlatButton(
              color: Colors.transparent,
              onPressed: () {},
              child: HeadlineText(
                title: 'Deny',
                color: Colors.white,
              ))

          ///Allow Permissions Buttons
        ],
      ),
    );
  }
}
