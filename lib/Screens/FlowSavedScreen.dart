import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flow/constants.dart';
import 'package:flow/Components/flow_app_bar.dart';
import 'package:flow/Components/search_bar.dart';

import 'package:flow/Components/sources_list_item.dart';

class FlowSavedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: FlowAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            // SearchBar(),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 8.0),
                child: BodyTextBold(
                  title: 'Saved Water Sources',
                  color: primarycolor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    WaterSourcesListItem(
                      id: '064',
                      distance: '456',
                      isflowingiconlink: 'Assets/icons/svgs/fi-rr-heart.svg',
                    ),
                  ],
                ),
              ),
            ),
            /*  Padding(
              padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
              child: Divider(
                height: 1,
                thickness: 1,
                color: primarycolor.withOpacity(0.5),
              ),
            ),*/
          ],
        ),
      ),
      // bottomNavigationBar: FlowBottomNavBar(),
    );
  }
}
