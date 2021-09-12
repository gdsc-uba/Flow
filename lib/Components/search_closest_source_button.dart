import 'package:flow/Components/directions/show_closest_source_dialog.dart';
import 'package:flow/Components/flow_maps.dart';
import 'package:flow/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_dialog_route.dart';
import 'directions/directions_model.dart';

class SearchClosestSourceButton extends StatelessWidget {
  final String _heroShowClosestSourceTag = 'hero_show_closest_source_tag';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(CustomHeroDialogRoute(
          builder: (context) {
            return ShowClosestSourceDialog();
          },
        ));
      },
      child: Hero(
        tag: _heroShowClosestSourceTag,
        child: Material(
          //  decoration: BoxDecoration(
          //   // shape: BoxShape.circle,
          //    color: Colors.white,
          //    borderRadius: BorderRadius.circular(32),
          //  ),
          color: Colors.white,

          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              'Assets/icons/svgs/fi-rr-search.svg',
              color: primarycolor,
            ),
          ),
        ),
      ),
    );
  }
}
