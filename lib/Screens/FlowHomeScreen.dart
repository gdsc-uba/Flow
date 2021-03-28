import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flow/Components/flow_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flow/Components/search_bar.dart';
import 'package:flow/Components/flow_maps.dart';

class FlowHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FlowAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            FlowMaps(),
            // SearchBar(),
          ],
        ),
      ),
      // bottomNavigationBar: FlowBottomNavBar(),
    );
  }
}
