import 'package:flow/Components/flow_location.dart';
import 'package:flow/constants.dart';
import 'package:flutter/material.dart';

class FlowAskPermissions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .25),
              child: Image(
                image: AssetImage('Assets/images/flow_logo.png'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HeadlineTextBold(
                  title: 'Allow Flow to access your location?',
                  color: primarycolor),
            ),
            SizedBox(
              height: 30,
            ),
            FloatingActionButton.extended(
              label: Text('Allow Location Permission'),
              onPressed: () {
                MyLocation();
              },
            )
          ],
        ),
      ),
    );
  }
}
