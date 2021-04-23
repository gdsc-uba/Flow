import 'package:flow/constants.dart';
import 'package:flutter/material.dart';
import 'package:flow/Components/Permissions.dart';

class FlowAskEnableLocation extends StatefulWidget {
  @override
  _FlowAskEnableLocationState createState() => _FlowAskEnableLocationState();
}

class _FlowAskEnableLocationState extends State<FlowAskEnableLocation> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
                    image: AssetImage('Assets/images/placeholder_image.png'),
                  ),
                ),
                SizedBox(height: 20),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
                //   child: Text(
                //     'Flow needs access to your location for certain features to work properly',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 16,
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
                  child: Text(
                    'It seems your location isn\'t turned on',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),

            ///Allow Permissions Buttons
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primarycolor,
              ),
              // ignore: deprecated_member_use
              child: FlatButton(
                child: HeadlineTextBold(
                  title: 'Turn it on',
                  color: Colors.white,
                ),
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pop(requestServiceEnabled());
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
                title: 'Leave off',
                color: primarycolor,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
