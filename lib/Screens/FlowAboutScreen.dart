import 'package:flow/constants.dart';
import 'package:flutter/material.dart';

class FlowAboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * .2),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * .25),
                      child: Image(
                        image: AssetImage('Assets/images/flow_logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    HeadlineTextBold(
                        title: 'Find water easily around Bambili',
                        color: primarycolor),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * .07),
                child: Column(
                  children: [
                    BodyText(
                      title: 'Developed By',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    BodyText(
                      title: 'Ida Delphine',
                      color: primarycolor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    BodyText(
                      title: 'Alouzeh Brandone',
                      color: primarycolor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    BodyText(
                      title: 'Nuikweh Lewis',
                      color: primarycolor,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'This is a project by Google Developer Student Clubs- University of Bamenda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
