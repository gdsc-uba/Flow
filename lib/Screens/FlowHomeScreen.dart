import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow/Components/Permissions.dart';
import 'package:flow/Components/flow_location.dart';
import 'package:flow/Screens/FlowAskPermissionsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flow/Components/flow_app_bar.dart';
import 'package:flow/Screens/FlowAskEnableLocationScreen.dart';
import 'package:flow/Components/flow_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class FlowHomeScreen extends StatefulWidget {
  @override
  _FlowHomeScreenState createState() => _FlowHomeScreenState();
}

class _FlowHomeScreenState extends State<FlowHomeScreen> {
  Location location = Location();
  double shortestDistance;
  String closestSourceDistance;
  String closestSourceID;
  String closestSourceDescription;
  List<double> sourceDistancesList;
  LatLng currentLocation;
  LatLng markerLocation;
  GeoPoint firebaseLocation;

  final Stream<QuerySnapshot> flowFirestoreStream =
      FirebaseFirestore.instance.collection('flow_water_sources').snapshots();

  // @override
  // void initState() {
  //   //getCurrentLocation();
  //   Future.delayed(Duration(seconds: 2), () {
  //     calculateClosestSource();
  //   });
  //
  //   super.initState();
  // }

  Future<void> checkPermissionStatus() async {
    Future.delayed(Duration(seconds: 5), () async {
      PermissionStatus currentPermissionStatus = await getPermissionStatus();
      print(
          'permission  in check perm func from permisssion page getpermstat func is : ${await getPermissionStatus()}');

      if (currentPermissionStatus != PermissionStatus.granted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => FlowAskPermissions()),
          );
        });
      }
    });
  }

  Future<void> checkIfServiceEnabled() async {
    Future.delayed(Duration(seconds: 7), () async {
      bool serviceEnabledStatus = await checkServiceEnabled();

      print(
          'wether enabled status from permission page is : ${await checkServiceEnabled()}');

      if (serviceEnabledStatus != true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => FlowAskEnableLocation()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      checkPermissionStatus();
      checkIfServiceEnabled();
    });

    return Scaffold(
      appBar: FlowAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            FlowMaps(),
            //calculateClosestSource(),
            // SearchBar(),
          ],
        ),
      ),
      //  bottomNavigationBar: FlowBottomNavBar(),
    );
  }

  // ///getting the current location
  // getCurrentLocation() async {
  //   final LocationData currentLocData = await getLocation();
  //   currentLocation = LatLng(currentLocData.latitude, currentLocData.longitude);
  //
  //   print('current location data is $currentLocation');
  //
  //   return currentLocation;
  // }
}
