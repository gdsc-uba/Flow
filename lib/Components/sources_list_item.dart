import 'package:flutter/material.dart';
import 'package:flow/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaterSourcesListItem extends StatelessWidget {
  final String id;
  final String distance;
  final String isflowingiconlink;

  const WaterSourcesListItem({
    Key key,
    this.id,
    this.distance,
    this.isflowingiconlink,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        /*border: Border.all(color: primarycolor.withOpacity(.5), width: 1),*/
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
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
            Row(
              children: [
                BodyTextBold(
                  title: distance,
                  color: primarycolor,
                ),
                BodyText(
                  title: ' approx.',
                  color: textcolor,
                ),
              ],
            ),
            SvgPicture.asset(
              isflowingiconlink,
              color: primarycolor,
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                padding: EdgeInsets.zero,
                enableFeedback: true,
                icon: SvgPicture.asset(
                  'Assets/icons/svgs/fi-rr-heart.svg',
                  color: primarycolor,
                ),
                onPressed: null) //onpressed invoke save action
          ],
        ),
      ),
    );
  }
}
