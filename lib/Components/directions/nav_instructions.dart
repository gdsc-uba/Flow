import 'package:flow/constants.dart';
import 'package:flutter/material.dart';

import 'directions_model.dart';

class NavigationInstructions extends StatelessWidget {
  final String tapID;
  final String distance;
  final String time;
  final String tapDescription;
  final Directions navInfo;

  const NavigationInstructions(
      {Key key,
      this.tapID,
      this.distance,
      this.time,
      this.tapDescription,
      this.navInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        minChildSize: .2,
        maxChildSize: .6,
        builder: (
          context,
          scrollController,
        ) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                color: primarycolor,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Text('Navigating To..'),
                      Text(tapID),
                      Text(tapDescription),
                      Row(
                        children: [
                          Text(distance),
                          Text(time),
                        ],
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                        // child: ListView.builder(
                        //   itemBuilder: ,
                        // ),
                        ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class NavInstrucListItem extends StatelessWidget {
  final String nextNavInstruction;
  final String detailedNavInstruction;

  NavInstrucListItem({this.nextNavInstruction, this.detailedNavInstruction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        children: [
          Text(nextNavInstruction),
          Divider(
            thickness: 3,
            color: primarycolor,
          ),
          SizedBox(
            height: 5,
          ),
          Text(detailedNavInstruction),
        ],
      ),
    );
  }
}
