import 'package:flow/constants.dart';
import 'package:flutter/material.dart';
import 'package:flow/Components/Permissions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlowAskPermissions extends StatefulWidget {
  @override
  _FlowAskPermissionsState createState() => _FlowAskPermissionsState();
}

class _FlowAskPermissionsState extends State<FlowAskPermissions> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primarycolor,
      body: SafeArea(
        child: Column(
          children: [
            /// Image and text Area
            Spacer(),
            Container(
              padding: EdgeInsets.only(
                  left: screenWidth * .1, right: screenHeight * .15),
              //width: screenWidth * .8,
              child: SvgPicture.asset(
                'Assets/illustrations/request-location-on.svg',
                height: screenHeight * .5,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
              child: Text(
                'Flow needs access to your location for certain features to work properly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
              child: Text(
                'Allow Flow to access your location?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ///Allow Permissions Buttons
            Container(
              width: double.infinity,
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              // ignore: deprecated_member_use
              child: FlatButton(
                height: 45,
                child: HeadlineTextBold(
                  title: 'Allow Permissions',
                  color: primarycolor,
                ),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pop(requestPermissions());
                  });
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                });
              },
              color: Colors.transparent,
              child: HeadlineText(
                title: 'Deny',
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
