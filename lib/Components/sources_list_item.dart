import 'package:flutter/material.dart';
import 'package:flow/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaterSourcesListItemSavedScreen extends StatelessWidget {
  final String id;
  final String distance;
  final String isflowingiconlink;
  final Widget iconButtonWidget;
  final Widget moreInfoIcon;

  const WaterSourcesListItemSavedScreen({
    Key key,
    this.id,
    this.distance,
    this.isflowingiconlink,
    this.iconButtonWidget,
    this.moreInfoIcon,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 8),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        /*border: Border.all(color: primarycolor.withOpacity(.5), width: 1),*/
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                BodyText(
                  title: 'ID: ',
                  color: textcolor,
                ),
                BodyTextBold(
                  title: id,
                  color: primarycolor,
                ),
              ],
            ),
            Spacer(),
            BodyTextBold(
              title: distance,
              color: primarycolor,
            ),
            Spacer(),
            SvgPicture.asset(
              isflowingiconlink,
              color: primarycolor,
            ),
            moreInfoIcon,
            iconButtonWidget,
          ],
        ),
      ),
    );
  }
}

class WaterSourcesListItemFindScreen extends StatelessWidget {
  final String id;
  final String description;
  final String isflowingiconlink;
  final Widget iconButtonWidget;
  final Widget moreInfoIcon;
  final Color flowIconColor;

  const WaterSourcesListItemFindScreen({
    Key key,
    this.id,
    this.description,
    this.isflowingiconlink,
    this.iconButtonWidget,
    this.moreInfoIcon,
    this.flowIconColor,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 8),
      padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        /*border: Border.all(color: primarycolor.withOpacity(.5), width: 1),*/
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              BodyText(
                title: 'ID: ',
                color: textcolor,
              ),
              BodyTextBold(
                title: id,
                color: primarycolor,
              ),
            ],
          ),
          SizedBox(width: 10),
          BodyText(
            title: description,
            color: textcolor,
          ),
          Spacer(),
          SvgPicture.asset(
            isflowingiconlink,
            color: flowIconColor,
          ),
          moreInfoIcon,
          iconButtonWidget,
        ],
      ),
    );
  }
}
