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
  final bool bottomSheetIsTypeTap;
  final bool bottomSheetIsFlowing;
  final String distance;

  BottomSheetInfo({
    Key key,
    this.bottomSheetID,
    this.bottomSheetDescription,
    this.bottomSheetIsTypeTap,
    this.bottomSheetIsFlowing,
    this.distance,
  }) : super(key: key);

  @override
  _BottomSheetInfoState createState() => _BottomSheetInfoState();
}

class _BottomSheetInfoState extends State<BottomSheetInfo> {
  String ifIsTypeTap;
  String ifIsFlowing;
  bool isSaved;

  // ignore: deprecated_member_use
  List<FlowSaved> flowList = List<FlowSaved>();

  ///Instantiating shared Prefs

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

  @override
  Widget build(BuildContext context) {
    if (widget.bottomSheetIsTypeTap == true) {
      ifIsTypeTap = 'Tap';
    } else {
      ifIsTypeTap = 'Stream';
    }

    if (widget.bottomSheetIsFlowing == true) {
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
                elevation: 0,
                label: Text('Get Directions'),
                backgroundColor: primarycolor,
                onPressed: () {},
              ),
              SizedBox(width: 40),
              checkIfIsSavedFAB(),
            ],
          ),

          /// buttons row
        ],
      ),
    );
  }

  /// method to check if is saved and return appropriate icon

  Widget checkIfIsSavedFAB() {
    Widget checkIfSaved;

    ///loop to go through the entire list and check if this source has been saved or not
    if (flowList.isEmpty) {
      checkIfSaved = FABToAddTosave();
    } else {
      for (int i = 0; i < flowList.length; i++) {
        if (flowList[i].savedID == widget.bottomSheetID) {
          checkIfSaved = FABToRemoveFromSaved();
        } else {
          checkIfSaved = FABToAddTosave();
        }
      }
    }
    return checkIfSaved;
  }

  /// custom FABs to add and remove from saved
  // ignore: non_constant_identifier_names
  Widget FABToAddTosave() {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: primarycolor.withOpacity(.2),
      child: SvgPicture.asset('Assets/icons/svgs/fi-rr-heart.svg',
          color: primarycolor),
      onPressed: () {
        setState(() {
          // isSaved = true;
          addToSavedList(FlowSaved(
            savedID: widget.bottomSheetID,
            savedDescription: widget.bottomSheetDescription,
            savedDistance: widget.distance.toString(),
            savedFlowing: widget.bottomSheetIsFlowing,
            savedTypeTap: ifIsTypeTap,
            // savedisSaved: isSaved,
          ));

          print('is saved?: $isSaved');
          print('bottom sheet id: ${widget.bottomSheetID}');
        });
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget FABToRemoveFromSaved() {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: secondarycolor.withOpacity(.2),
      child: SvgPicture.asset('Assets/icons/svgs/fi-sr-heart.svg',
          color: secondarycolor),
      onPressed: () {
        setState(() {
          //  isSaved = false;
          removeFromSavedList(
            FlowSaved(
              savedID: widget.bottomSheetID,
              savedDescription: widget.bottomSheetDescription,
              savedDistance: widget.distance.toString(),
              savedFlowing: widget.bottomSheetIsFlowing,
              savedTypeTap: ifIsTypeTap,
              // savedisSaved: isSaved,
            ),
            widget.bottomSheetID,
          );

          print('is saved from bottom sheet page?: $isSaved');
          print('bottom sheet id: ${widget.bottomSheetID}');
        });
      },
    );
  }

  ///methods to add, remove, store and load data into a json list
  void addToSavedList(FlowSaved savedItem) {
    flowList.add(savedItem);
    setState(() {});
    saveSPData();
  }

  void removeFromSavedList(FlowSaved savedItem, tapID) {
    flowList.removeWhere((savedItem) => savedItem.savedID == tapID);
    if (flowList.isEmpty) setState(() {});
    saveSPData();
  }

  void saveSPData() {
    List<String> spList = flowList.map((savedItem) {
      return json.encode(savedItem.toMap());
    }).toList();
    flowSharedPreferences.setStringList('list', spList);
    setState(() {});
    // await FlowSharedPreferences.setString(SavedID, widget.bottomSheetID);

    print(spList);
  }

  void loadSPData() {
    List<String> spList = flowSharedPreferences.getStringList('list');
    flowList = spList
        .map((savedItem) => FlowSaved.fromMap(json.decode(savedItem)))
        .toList();
    setState(() {});
  }
}
