import 'dart:convert';
import 'package:flow/Components/bottom_sheet_info.dart';
import 'package:flow/Components/flow_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flow/constants.dart';
import 'package:flow/Components/flow_app_bar.dart';
import 'package:flow/Components/search_bar.dart';
import 'package:flow/Components/sources_list_item.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlowSavedScreen extends StatefulWidget {
  @override
  _FlowSavedScreenState createState() => _FlowSavedScreenState();
}

class _FlowSavedScreenState extends State<FlowSavedScreen> {
  // ignore: deprecated_member_use
  List<FlowSaved> flowList = List<FlowSaved>();
  String ifIsFlowingIconLink;
  bool typeTap;

  ///instantiating shared Prefs
  SharedPreferences flowSharedPreferences;

  @override
  void initState() {
    initFlowSharedPreferences();
    super.initState();
  }

  ///initialising Shared Preferences
  initFlowSharedPreferences() async {
    flowSharedPreferences = await SharedPreferences.getInstance();
    loadSPData();
  }

  Widget buildSavedList(BuildContext context, int index, FlowSaved savedItem) {
    // print('from saved screen: ${flowList[index].savedID}');

    if (flowList[index].savedFlowing == true) {
      ifIsFlowingIconLink = 'Assets/icons/svgs/fi-sr-flowing-filled.svg';
    } else {
      ifIsFlowingIconLink = 'Assets/icons/svgs/fi-rr-not-flowing.svg';
    }
    if (flowList[index].savedTypeTap == 'Tap') {
      typeTap = true;
    } else {
      typeTap = false;
    }
    return WaterSourcesListItem(
      id: flowList[index].savedID,
      distance: flowList[index].savedDistance.toString(),
      isflowingiconlink: ifIsFlowingIconLink,
      moreInfoIcon: IconButton(
          padding: EdgeInsets.zero,
          enableFeedback: true,
          icon: SvgPicture.asset(
            'Assets/icons/svgs/fi-rr-angle-small-down.svg',
            color: primarycolor,
          ),
          onPressed: () {
            setState(() {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BottomSheetInfo(
                      bottomSheetID: flowList[index].savedID,
                      bottomSheetDescription: flowList[index].savedDescription,
                      bottomSheetIsTypeTap: typeTap,
                      bottomSheetIsFlowing: flowList[index].savedFlowing,
                    );
                  });
            });
          }),
      iconButtonWidget: IconButton(
          padding: EdgeInsets.zero,
          enableFeedback: true,
          icon: SvgPicture.asset(
            'Assets/icons/svgs/fi-rr-trash.svg',
            color: secondarycolor,
          ),
          onPressed: () {
            removeFromSavedList(
              FlowSaved(
                savedID: flowList[index].savedID,
                savedDescription: flowList[index].savedDescription,
                savedDistance: flowList[index].savedDistance,
                savedFlowing: flowList[index].savedFlowing,
                savedTypeTap: flowList[index].savedTypeTap,
              ),
              flowList[index].savedID,
            );
            setState(() {});
          }),
    );
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (flowList.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: FlowAppBar(),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .25),
                  child: Image.asset('Assets/images/placeholder_image.png'),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .15),
                  child: Text(
                    'You haven\'t saved any water sources yet',
                    style: TextStyle(
                        color: primarycolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Once you save some, they\'ll appear here',
                  style: TextStyle(
                      color: textcolor.withOpacity(.6),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: screenHeight * .15,
                ),
              ],
            ),
          ],
        ),
      );
    } else {
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
                    itemCount: flowList.length,
                    itemExtent: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return buildSavedList(context, index, flowList[index]);
                    }),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: FlowBottomNavBar(),
      );
    }
  }

  ///Shared Preferences methods
  void saveSPData() {
    List<String> spList = flowList.map((savedItem) {
      return json.encode(savedItem.toMap());
    }).toList();
    flowSharedPreferences.setStringList('list', spList);
    setState(() {});
  }

  void loadSPData() {
    List<String> spList = flowSharedPreferences.getStringList('list');
    flowList = spList
        .map((savedItem) => FlowSaved.fromMap(json.decode(savedItem)))
        .toList();
    setState(() {});
  }

  removeFromSavedList(FlowSaved savedItem, tapID) {
    flowList.removeWhere((savedItem) => savedItem.savedID == tapID);
    if (flowList.isEmpty) setState(() {});
    saveSPData();
  }
}
