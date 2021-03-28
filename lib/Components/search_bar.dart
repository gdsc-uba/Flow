import 'package:flutter/material.dart';
import 'package:flow/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: textcolor.withOpacity(.1),
            spreadRadius: 3,
            blurRadius: 7,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: BodyText(
              title: 'Search By Radius',
              color: primarycolor.withOpacity(.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: SvgPicture.asset(
                'Assets/icons/svgs/fi-rr-search.svg',
                color: primarycolor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
