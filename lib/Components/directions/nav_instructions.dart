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
    Size screenSize = MediaQuery.of(context).size;
    return Material(
      child: DraggableScrollableSheet(
          minChildSize: .3,
          maxChildSize: .6,
          builder: (
            context,
            scrollController,
          ) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                height: screenSize.height * .5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Text(
                        'Navigating To..',
                        style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.black12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 40, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadlineTextBold(
                            title: tapID,
                            color: primarycolor,
                          ),
                          SizedBox(height: 10),
                          BodyText(
                            title: tapDescription,
                            color: textcolor,
                          ),
                          // Row(
                          //   children: [
                          //     Text(distance),
                          //     Text(time),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    Positioned(
                      top: screenSize.height * .2,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text('sup'),
                              Text('sup'),
                              Text('sup'),
                              Text('sup'),
                              Text('sup'),
                              Text('sup'),
                              Text('sup'),
                            ],
                          ),
                          // child: ListView.builder(
                          //   itemBuilder: ,
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
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
