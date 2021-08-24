import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow/Components/flow_location.dart';
import 'package:flow/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../flow_maps.dart';
import 'directions_model.dart';
import 'distance_calculator.dart';

class ShowClosestSourceDialog extends StatefulWidget {
  @override
  _ShowClosestSourceDialogState createState() =>
      _ShowClosestSourceDialogState();
}

class _ShowClosestSourceDialogState extends State<ShowClosestSourceDialog> {
  final Stream<QuerySnapshot> flowFirestoreStream =
      FirebaseFirestore.instance.collection('flow_water_sources').snapshots();

  LatLng markerLocation;

  LatLng currentLocation;

  double shortestDistance;

  String closestSourceID;

  GeoPoint closestSourceGeopoint;

  LatLng closestSourceLocation;

  String closestSourceDescription;

  List<double> sourceDistancesList = [];

  List<String> sourceIDsList = [];

  List<GeoPoint> sourceLocationList = [];

  Directions directionInfo;

  getLoc() async {
    LocationData currentLoc = await getLocation();
    currentLocation = LatLng(currentLoc.latitude, currentLoc.longitude);
    return currentLocation;
  }

  @override
  initState() {
    super.initState();
    getLoc();
  }

  Widget build(BuildContext context) {
    ///Calculating distances and adding to the List;
    return StreamBuilder(
        stream: flowFirestoreStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CustomAlertHeroDialog(
                child: Column(
                  children: [
                    Text(
                      'Calculating closest source',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              );
            case ConnectionState.none:
              return CustomAlertHeroDialog(
                child: HeadlineTextBold(
                  title: 'You are offline',
                ),
              );
            default:
              Future.delayed(Duration(seconds: 3), () {
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  markerLocation = LatLng(
                      snapshot.data.docs[i]['location'].latitude,
                      snapshot.data.docs[i]['location'].longitude);
                  // sourceDistancesList = [];
                  // sourceIDsList = [];
                  // sourceLocationList = [];
                  // sourceDistancesList = [];
                  if (snapshot.data.docs[i]['isFlowing'] == true) {
                    // sourceIDsList = [];
                    sourceIDsList.add(snapshot.data.docs[i]['ID']);
                    //sourceLocationList = [];
                    sourceLocationList.add(snapshot.data.docs[i]['location']);
                    //sourceDistancesList = [];
                    sourceDistancesList.add(
                      distanceCalculator(currentLocation, markerLocation),
                    );
                  }
                }

                ///Getting the shortest distance in the Lists of Distances
                setState(() {
                  shortestDistance = sourceDistancesList.reduce(min);
                  int indexOfClosestSource =
                      sourceDistancesList.indexOf(shortestDistance);
                  closestSourceID = sourceIDsList[indexOfClosestSource];
                  closestSourceGeopoint =
                      sourceLocationList[indexOfClosestSource];
                  closestSourceLocation = LatLng(
                    closestSourceGeopoint.latitude,
                    closestSourceGeopoint.longitude,
                  );
                });
                print('does current location change lets see:$currentLocation');
                print('list of distances is $sourceDistancesList');
                print('shortest distance within the list is $shortestDistance');
                print('shortest source ID within the list is $closestSourceID');
              });

              if (shortestDistance == null) {
                return CustomAlertHeroDialog(
                  child: Column(
                    children: [
                      Text(
                        'Calculating closest source',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      CircularProgressIndicator.adaptive(),
                    ],
                  ),
                );
              } else {
                return CustomAlertHeroDialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${closestSourceID ?? 'Calculating'}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: primarycolor),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'is closest to you, and marked as flowing',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      HeadlineTextBold(
                        title: '${shortestDistance.toStringAsFixed(2)} Km',
                        color: primarycolor,
                      ),
                      SizedBox(height: 30),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Feedback.forTap(context);
                                Navigator.of(context).pop(
                                  FlowMaps().directionInfo = await FlowMaps()
                                      .getDirections(currentLocation,
                                          closestSourceLocation),
                                );
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: primarycolor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 11.0),
                                  child: BodyTextBold(
                                    title: 'Lets go!',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () async {
                                Feedback.forTap(context);
                                // directionInfo = await FlowMaps().getDirections(
                                //     currentLocation, closestSourceLocation);
                                // Navigator.of(context).pop(directionInfo);

                                sourceDistancesList = [];
                                sourceIDsList = [];
                                sourceLocationList = [];
                                sourceDistancesList = [];
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: primarycolor,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10.0),
                                  child: BodyText(
                                    title: 'No thanks',
                                    color: primarycolor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          }
        });
  }
}

class CustomAlertHeroDialog extends StatelessWidget {
  final Widget child;
  final String _heroShowClosestSourceTag = 'hero_show_closest_source_tag';

  const CustomAlertHeroDialog({Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: _heroShowClosestSourceTag,
        child: Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * .8,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
