import 'package:flutter/material.dart';
import 'package:flow/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class BottomSheetInfo extends StatelessWidget {
  final String bottomSheetID;
  final String bottomSheetDescription;
  bool bottomSheetisTypeTap;
  bool bottomSheetisFlowing;
  String ifIsTypeTap;
  String ifIsFlowing;
  String distance;

  BottomSheetInfo({
    Key key,
    this.bottomSheetID,
    this.bottomSheetDescription,
    this.bottomSheetisTypeTap,
    this.bottomSheetisFlowing,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bottomSheetisTypeTap == true) {
      ifIsTypeTap = 'Tap';
    } else {
      ifIsTypeTap = 'Stream';
    }

    if (bottomSheetisFlowing == true) {
      ifIsFlowing = 'Flowing';
    } else {
      ifIsFlowing = 'Not Flowing';
    }

    return Container(
      padding: EdgeInsets.all(20),
      // height: MediaQuery.of(context).size.height * .4,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BodyText(title: 'ID:'),
              SizedBox(width: 8),
              HeadlineTextBold(
                title: bottomSheetID,
                color: primarycolor,
              )
            ],
          ),
          SizedBox(height: 15),
          BodyText(
            title: bottomSheetDescription,
          ),
          SizedBox(height: 15),
          Row(
            children: [
              BodyText(
                title: 'Type: ',
              ),
              SizedBox(
                width: 8,
              ),
              HeadlineTextBold(
                title: ifIsTypeTap,
                color: primarycolor,
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyText(title: 'Status:'),
                    Text(
                      ifIsFlowing,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primarycolor,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyText(title: 'Approx. Distance:'),
                    Text(
                      'N/A m',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primarycolor,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              FloatingActionButton.extended(
                icon: SvgPicture.asset(
                  'Assets/icons/svgs/fi-rr-directions.svg',
                  color: Colors.white,
                  height: 20,
                ),
                elevation: 3,
                label: Text('Get Directions'),
                backgroundColor: primarycolor,
                onPressed: () {},
              ),
              SizedBox(
                width: 30,
              ),
              FloatingActionButton(
                elevation: 3,
                backgroundColor: primarycolor,
                child: SvgPicture.asset(
                  'Assets/icons/svgs/fi-rr-heart.svg',
                  color: Colors.white,
                  height: 20,
                ),
                onPressed: () {},
              ),
            ],
          )

          /// buttons row
        ],
      ),
    );
  }
}
