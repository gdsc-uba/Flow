import 'dart:convert';

import 'package:flow/Components/flow_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flow/constants.dart';
import 'package:flow/Components/flow_app_bar.dart';
import 'package:flow/Components/search_bar.dart';
import 'package:flow/Components/sources_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlowSavedScreen extends StatefulWidget {
  @override
  _FlowSavedScreenState createState() => _FlowSavedScreenState();
}

class _FlowSavedScreenState extends State<FlowSavedScreen> {
  @override
  Widget BuildSavedList() {
    return WaterSourcesListItem(
      id: 'swr',
      distance: 'N/A m',
      isflowingiconlink: 'Assets/icons/svgs/fi-rr-directions.svg',
    );
  }

  // ///instantialintg shared Prefs
  // SharedPreferences FlowSharedPreferences;
  //
  // @override
  // void initState() {
  //   initFlowSharedPreferences();
  //   super.initState();
  // }
  //
  // ///initialising Shared Preferences
  // initFlowSharedPreferences() async {
  //   FlowSharedPreferences = await SharedPreferences.getInstance();
  // }
  //
  // ///method to get Shared Prefs data
  //
  // void retrievSPData(){
  //   List<String> SPList = FlowSharedPreferences.getStringList('list');
  //   SPList = SPList.map((item) => prefs.getStringList.(json.decode(item)))
  //             .toList();
  //
  //
  // }

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
              child: ListView.builder(
                  itemCount: 5,
                  itemExtent: 50,
                  itemBuilder: (context, index) {
                    return BuildSavedList();
                  }),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: FlowBottomNavBar(),
    );
  }
}
