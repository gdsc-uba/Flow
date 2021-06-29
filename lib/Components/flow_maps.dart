import 'package:flow/Components/Permissions.dart';
import 'package:flow/Components/directions/distance_calculator.dart';
import 'package:flow/Components/directions/prompt_closest_source.dart';
import 'package:flow/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow/Components/bottom_sheet_info.dart';
import 'package:location/location.dart';
import 'directions/directions_repository.dart';
import 'directions/directions_model.dart';
import 'bottom_sheet_info.dart';
import 'flow_location.dart';
import 'flow_snackbar.dart';
import 'dart:math';

// ignore: must_be_immutable
class FlowMaps extends StatefulWidget {
  FlowMaps() : super();
  Directions directionInfo;

  ///Get Directions func
  getDirections(LatLng origin, LatLng destination) async {
    final directions = await DirectionsRepository()
        .getDirections(origin: origin, destination: destination);

    directionInfo = directions;

    return directionInfo;
  }

  // final String title = "location";

  @override
  _FlowMapsState createState() => _FlowMapsState(directionInfo);
}

class _FlowMapsState extends State<FlowMaps> {
  // Completer<GoogleMapController> _controller = Completer();
  static final LatLng _center = const LatLng(6.012484, 10.259225);
  final Set<Marker> flowMarkers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  GoogleMapController mapController;
  BitmapDescriptor mapMarkerRed;
  BitmapDescriptor mapMarkerGreen;
  BitmapDescriptor mapMarker;
  Directions directionInfo;
  Directions dirInfoFromSheet;
  Directions dirInfoFromClosestSource;
  LatLng currentLocation;
  LatLng markerLocation;

  //LatLng currentLocation = LatLng(6.0073798, 10.2478352);
  //LatLng finalLocation = LatLng(6.0113798, 10.2678352);
  List<double> calculatedDistances;

  double shortestDistance = 1;
  String closestSourceDistance;
  String closestSourceID;
  String closestSourceDescription;
  List<double> sourceDistancesList;
  GeoPoint firebaseLocation;
  LatLng markerLocForCalc;

  final Stream<QuerySnapshot> flowFirestoreStream =
      FirebaseFirestore.instance.collection('flow_water_sources').snapshots();

  _FlowMapsState(this.directionInfo);

  Set<Marker> setMarkers() {
    return flowMarkers;
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
    //getCurrentLocation();
    //assignDirInfo();
  }

  ///Setting custom marker icons
  void setCustomMarker() async {
    Size screenSize = MediaQuery.of(context).size;
    //Size markerSize;
    if (screenSize.width < 1000) {
      mapMarkerRed = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), 'Assets/images/marker-icon-red-small.png');
      mapMarkerGreen = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), 'Assets/images/marker-icon-green-small.png');
    } else {
      mapMarkerRed = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), 'Assets/images/marker-icon-red.png');
      mapMarkerGreen = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), 'Assets/images/marker-icon-green.png');
    }

    // setState(() {});
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  ///getting the current location
  getCurrentLocation() async {
    PermissionStatus currentPermissionStatus = await getPermissionStatus();
    if (currentPermissionStatus == PermissionStatus.granted) {
      print('get current location is running from flow maps');
      final LocationData currentLocData = await getLocation();
      currentLocation =
          LatLng(currentLocData.latitude, currentLocData.longitude);

      print('current location data is $currentLocation');
      return currentLocation;
      // }
    }
  }

  /// function to toggle between normal view and satellite view when the button is pressed
  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  /// button widget
  Widget button(
    Function function, //  IconData icon,
    String iconLink,
  ) {
    return FloatingActionButton(
      // mini: true,
      onPressed: function,
      backgroundColor: Colors.white,
      child: SvgPicture.asset(
        iconLink,
        color: primarycolor,
        // height: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadFlowMaps(),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 80, 16, 16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                button(
                  _onMapTypeButtonPressed,
                  //   Icons.map,
                  'Assets/icons/svgs/fi-rr-map-change.svg',
                ), // toggle map type button
                SizedBox(height: 10.0),

                /*  button(
                    _onAddMarkerButtonPressed,
                    //  Icons.add_location,
                    'Assets/icons/svgs/fi-rr-marker-add.svg'), // add marker botton
                SizedBox(height: 10.0), */

                // button(_goToPosition1, Icons.location_searching),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Getting the marker coordinates and adding to maps.
  Widget loadFlowMaps() {
    return StreamBuilder(
        stream: flowFirestoreStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                ),
              );

            case ConnectionState.none:
              return FlowSnackBar(
                text: 'You are offline',
              );

            default:
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                if (snapshot.data.docs[i]['isFlowing'] == false) {
                  mapMarker = mapMarkerRed;
                } else {
                  mapMarker = mapMarkerGreen;
                }
                markerLocation = LatLng(
                    snapshot.data.docs[i]['location'].latitude,
                    snapshot.data.docs[i]['location'].longitude);

                flowMarkers.add(
                  new Marker(
                    flat: false,
                    draggable: false,
                    zIndex: 5,
                    icon: mapMarker,
                    markerId: MarkerId(snapshot.data.docs[i]['ID']),
                    position: markerLocation,
                    infoWindow: InfoWindow(title: snapshot.data.docs[i]['ID']),

                    onTap: () async {
                      dirInfoFromSheet = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return BottomSheetInfo(
                              bottomSheetID: snapshot.data.docs[i]['ID'],
                              bottomSheetDescription: snapshot.data.docs[i]
                                  ['description'],
                              bottomSheetIsTypeTap: snapshot.data.docs[i]
                                  ['isTypeTap'],
                              bottomSheetIsFlowing: snapshot.data.docs[i]
                                  ['isFlowing'],
                              tapLocation: snapshot.data.docs[i]['location'],
                              // distance: directionInfo.totalDistance,
                            );
                          });
                      // NavigationInstructions(
                      //   tapID: snapshot.data.docs[i]['ID'],
                      //   tapDescription: snapshot.data.docs[i]['description'],
                      //   time: dirInfoFromSheet.totalDistance,
                      //   distance: dirInfoFromSheet.totalDistance,
                      //   navInfo: dirInfoFromSheet,
                      // );

                      directionInfo = dirInfoFromSheet;
                      setState(() {});
                    }, //load bottom sheet
                  ),
                );
              } // end of loop

              // currentLocation = getCurrentLocation();
              //
              // /// Calculating the distance to all sources and finding the closest
              // Future.delayed(Duration(seconds: 5), () {
              //   for (int i = 0; i < snapshot.data.docs.length; i++) {
              //     LatLng markerLoc = LatLng(
              //       snapshot.data.docs[i]['location'].latitude,
              //       snapshot.data.docs[i]['location'].longitude,
              //     );
              //     sourceDistancesList = [
              //       calculateClosestSource(currentLocation, markerLoc),
              //     ];
              //   } //end for loop
              //
              //   print('distancelist = $sourceDistancesList');
              //
              //   ///Finding shortest distance and its index
              //   shortestDistance = sourceDistancesList.reduce(min);
              //   var index = sourceDistancesList
              //       .indexOf(sourceDistancesList.reduce(min));
              //   print(shortestDistance);
              //   print('shortest distance index is $index');
              //
              //   // popUpClosestSource();
              // });

              return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),
                  mapType: _currentMapType,
                  markers: setMarkers(),
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  polylines: {
                    if (directionInfo != null)
                      Polyline(
                        geodesic: true,
                        polylineId: const PolylineId('overview_polyline'),
                        color: primarycolor,
                        width: 6,
                        zIndex: 1,
                        endCap: Cap.roundCap,
                        startCap: Cap.roundCap,
                        jointType: JointType.bevel,
                        points: directionInfo.polylinePoints
                            .map((e) => LatLng(e.latitude, e.longitude))
                            .toList(),
                      ),
                  }
                  //   onMapCreated: (GoogleMapController controller) {
                  //      mapController = controller;
                  //    },
                  );
          }
        });
  }

  ///method to find and show the closest water source
  calculateClosestSource(
    LatLng currentLocation,
    LatLng markerLocation,
  ) async {
    // final double sourceDistance =
    //     distanceCalculator(currentLocation, markerLocation);

    return distanceCalculator(currentLocation, markerLocation);
    // ///sorting for the shortest distance
    // if (shortestDistance !=null &&
    //     documentSnapshot[i]['ifIsFlowing'] == true) {
    //   closestSourceDistance = shortestDistance.toStringAsFixed(2);
    //   closestSourceID = documentSnapshot[i]['ID'];
    //   closestSourceDescription = documentSnapshot[i]['description'];
    //   firebaseLocation = documentSnapshot[i]['location'];
    //   markerLocForCalc =
    //       LatLng(firebaseLocation.latitude, firebaseLocation.longitude);
    //   return shortestDistance;
    // }
  }

  ///Show Closest Source Popup
  Future<Directions> popUpClosestSource() async {
    dirInfoFromClosestSource = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowClosestSource(
            id: closestSourceID,
            description: closestSourceDescription,
            distance: '$closestSourceDistance Km',
          );
        });
    setState(() {
      directionInfo = dirInfoFromClosestSource;
    });

    return directionInfo;
  }
}
