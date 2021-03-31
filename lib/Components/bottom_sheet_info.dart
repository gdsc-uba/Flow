import 'package:flutter/material.dart';
import 'package:flow/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flow/Components/flow_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BottomSheetInfo extends StatefulWidget {
  final String bottomSheetID;
  final String bottomSheetDescription;
  bool bottomSheetisTypeTap;
  bool bottomSheetisFlowing;
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
  _BottomSheetInfoState createState() => _BottomSheetInfoState();
}

class _BottomSheetInfoState extends State<BottomSheetInfo> {
  // ignore: deprecated_member_use
  // List<int> flowSPList = List<int>();
  // ignore: deprecated_member_use
  List<flowSharedPrefs> flowSPList = List<flowSharedPrefs>();

  ///Instanciating shared Prefs
  SharedPreferences FlowSharedPreferences;

  @override
  void initState() {
    initFlowSharedPreferences();
    super.initState();
  }

  ///initialising Shared Preferences
  initFlowSharedPreferences() async {
    FlowSharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  String ifIsTypeTap;
  String ifIsFlowing;
  bool isSaved;

  @override
  Widget build(BuildContext context) {
    if (widget.bottomSheetisTypeTap == true) {
      ifIsTypeTap = 'Tap';
    } else {
      ifIsTypeTap = 'Stream';
    }

    if (widget.bottomSheetisFlowing == true) {
      ifIsFlowing = 'Flowing';
    } else {
      ifIsFlowing = 'Not Flowing';
    }

    /// method to add to save and perform all SP Task
    Future<void> flowAddToSaved() async {
      if (isSaved) {
        // List<String> SPList =
        //     flowSPList.map((item) => json.encode(item.toString())).toList();
        // flowSPList.setStringList(
        //   'sourceID',
        // );

        List<String> SPList = FlowSharedPreferences.getStringList('list');
        flowSPList =
            SPList.map((item) => flowSharedPrefs.fromMap(json.decode(item)))
                .toList();
        FlowSharedPreferences.setString('sourceID', widget.bottomSheetID);
        FlowSharedPreferences.setString(
            'sourceDescription', widget.bottomSheetDescription);
        FlowSharedPreferences.setString('sourceDistance', widget.distance);
        FlowSharedPreferences.setString('sourceFlowing', ifIsFlowing);
        FlowSharedPreferences.setString('sourceTypeTap', ifIsTypeTap);

        print(SPList);
      }
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
                title: widget.bottomSheetID,
                color: primarycolor,
              )
            ],
          ),
          SizedBox(height: 15),
          BodyText(
            title: widget.bottomSheetDescription,
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

              // FloatingActionButton(
              //   elevation: 3,
              //   backgroundColor: primarycolor,
              //   child: new IconButton(icon: Icon(
              //     isSaved
              //         ? Icons.favorite
              //         : Icons.favorite_border,
              //     size:20,
              //     color: isSaved
              //       ? Colors.white
              //       : Colors.white
              //   ),
              FloatingActionButton(
                elevation: 3,
                backgroundColor: primarycolor,
                child: SvgPicture.asset('Assets/icons/svgs/fi-rr-heart.svg',
                    color: Colors.white),
                //
                // isSaved
                //     ? SvgPicture.asset('Assets/icons/svgs/fi-sr-heart.svg',
                //         color: Colors.white)
                //     : SvgPicture.asset('Assets/icons/svgs/fi-rr-heart.svg',
                //         color: Colors.white),
                onPressed: () {
                  isSaved = true;
                  flowAddToSaved();
                },
              ),
              // child: SvgPicture.asset(
              //   'Assets/icons/sgs/fi-rr-heart.svg',
              //   color: Colors.white,
              //   height: 20,
              // ),
              //   onPressed: flowSaveData,
              // ),
            ],
          ),

          /// buttons row
        ],
      ),
    );
  }

  /* void addToSaved(
    flowSharedPrefs item,
    String ID ,
    String Description,
    String Distance,
    bool Flowing,
    bool TypeTap,
  ) {
    item.sourceID = ID;
    item.sourceDescription = Description;
    item.sourceDistance = Distance;
    item.sourceFlowing = Flowing;
    item.sourceTypeTap = TypeTap;
    flowSaveData();
  }*/

  ///method to save Shared Prefs data
  // void flowSaveData() {
  //   List<String> SPList =
  //       flowSPList.map((item) => json.encode(item.toInt())).toList();
  //   FlowSharedPreferences.setStringList('list', SPList);
  //
  //   print(SPList);
  //   setState(() {});
  // }

  // void flowSaveData() {
  //   if (isSaved) {
  //     List<String> SPList =
  //         flowSPList.map((item) => json.encode(item.toInt())).toList();
  //     // flowSPList.setStringList(
  //     //   'sourceID',
  //     // );
  //     prefs.setStringList('sourceID', bottomSheetID);
  //     prefs.setStringList('sourceDescription', SPList);
  //     prefs.setStringList('sourceDistance', SPList);
  //     prefs.setStringList('sourceFlowing', SPList);
  //     prefs.setStringList('sourceTypeTap', SPList);
  //   }
  // }

  // void flowGetData() {
  //   List<String> SPList = FlowSharedPreferences.getStringList('list');
  //   flowSPList =
  //       SPList.map((item) => flowSharedPrefs.fromMap(json.decode(item)))
  //           .toList();
  // }
}
