import 'package:flow/constants.dart';
import 'package:flutter/material.dart';
import 'package:flow/Components/Permissions.dart';

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
            Spacer(),

            /// Image and text Area
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
                SizedBox(height: 20),
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
                  child: HeadlineTextBold(
                      title: 'Allow Flow to access your location?',
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
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
