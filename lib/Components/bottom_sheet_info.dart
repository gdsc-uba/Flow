import 'package:flow/Components/directions/distance_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flow/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flow/Components/flow_shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:location/location.dart';
import 'directions/directions_model.dart';
import 'flow_maps.dart';
import 'flow_location.dart';

class BottomSheetInfo extends StatefulWidget {
  final String bottomSheetID;
  final String bottomSheetDescription;
  final bool bottomSheetIsTypeTap;
  final bool bottomSheetIsFlowing;
  final String distance;
  final LatLng tapLocation;

  BottomSheetInfo({
    Key key,
    this.bottomSheetID,
    this.bottomSheetDescription,
    this.bottomSheetIsTypeTap,
    this.bottomSheetIsFlowing,
    this.distance,
    this.tapLocation,
  }) : super(key: key);

  @override
  BottomSheetInfoState createState() => BottomSheetInfoState();
}

class BottomSheetInfoState extends State<BottomSheetInfo> {
  String ifIsTypeTap;
  String ifIsFlowing;
  bool isSaved;
  LatLng markerLocation;
  LatLng currentLocation;
  Directions dirInfo;
  String estDistance;
  Widget circularIndicator = SizedBox(width: 2);
  // Widget distanceText;

  // ignore: deprecated_member_use
  List<FlowSaved> flowList = List<FlowSaved>();

  //Instantiating shared Prefs
  SharedPreferences flowSharedPreferences;

  @override
  void initState() {
    super.initState();
    initFlowSharedPreferences();
    getCurrentLocation();
    // ifTapIsSaved();
    Future.delayed(Duration(seconds: 2), () {
      calcDistance();
    });

    //distanceCalculator(currentLocation, markerLocation);
  }

  Widget distanceText() {
    if (estDistance != null) {
      return Text(
        '$estDistance km',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: primarycolor,
          fontSize: 28,
        ),
      );
    } else {
      return Text(
        'Calculating',
        style: TextStyle(
          fontSize: 12,
          color: textcolor.withOpacity(.7),
        ),
      );
    }
  }

  ///initialising Shared Preferences
  initFlowSharedPreferences() async {
    flowSharedPreferences = await SharedPreferences.getInstance();
    loadSPData();
  }

  ///getting the current location
  getCurrentLocation() async {
    print('get current locationf from bottom sheet is running');
    final LocationData currentLocData = await getLocation();
    currentLocation = LatLng(currentLocData.latitude, currentLocData.longitude);

    print('current location data is $currentLocation');

    return currentLocation;
  }

  ///method to call the distance calculator

  calcDistance() async {
    final double calculatedDistance =
        distanceCalculator(currentLocation, markerLocation);
    setState(() {
      estDistance = calculatedDistance.toStringAsFixed(2);
    });
    print('estimated calculated distance is $estDistance');

    return estDistance;
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

    // markerLocation =
    //     LatLng(widget.tapLocation.latitude, widget.tapLocation.longitude);
    markerLocation = widget.tapLocation;

    // if (estDistance == null) {
    //   setState(() {
    //     estDistance = 'N/A';
    //   });
    // }

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
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BodyText(title: 'Approx. Distance:'),
                    distanceText(),
                    // Text(
                    //   '$estDistance km',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: primarycolor,
                    //     fontSize: 28,
                    //   ),
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
                onPressed: () async {
                  dirInfo = await FlowMaps()
                      .getDirections(currentLocation, markerLocation);
                  print(
                      'marker position is ${widget.tapLocation.latitude.toDouble()} and ${widget.tapLocation.longitude.toDouble()} ');
                  print(currentLocation);
                  print(dirInfo.polylinePoints);
                  setState(() {
                    circularIndicator = CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                    );
                  });

                  Future.delayed(Duration(seconds: 1), () async {
                    Navigator.pop(context, dirInfo);
                  });
                },
              ),
              SizedBox(width: 10),
              circularIndicator,
              SizedBox(width: 20),
              ifTapIsSaved(),
            ],
          ),

          /// buttons row
        ],
      ),
    );
  }

  /// method to check if is saved and return appropriate icon
  ifTapIsSaved() {
    Widget checkIfSaved;
    //loop to go through the entire list and check if this source has been saved or not

    if (flowList.isEmpty) {
      checkIfSaved = addToSavedFAB();
    } else {
      for (int i = 0; i < flowList.length; i++) {
        if (flowList[i].savedID == widget.bottomSheetID) {
          checkIfSaved = removeFromSavedFAB();
        } else {
          checkIfSaved = addToSavedFAB();
        }
      }
    }
    return checkIfSaved;
  }

  /// custom FABs to add and remove from saved
  // ignore: non_constant_identifier_names
  Widget addToSavedFAB() {
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
            savedDistance: '$estDistance Km',
            savedFlowing: widget.bottomSheetIsFlowing,
            savedTypeTap: ifIsTypeTap,
            savedTapLocationLatitude: markerLocation.latitude.toDouble(),
            savedTapLocationLongitude: markerLocation.longitude.toDouble(),

            // savedisSaved: isSaved,
          ));

          print('is saved?: $isSaved');
          print('bottom sheet id: ${widget.bottomSheetID}');
        });
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget removeFromSavedFAB() {
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
              savedTapLocationLatitude: markerLocation.latitude.toDouble(),
              savedTapLocationLongitude: markerLocation.longitude.toDouble(),
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
    //setState(() {});
  }
}
