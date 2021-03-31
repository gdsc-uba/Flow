import 'package:flow/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow/Components/bottom_sheet_info.dart';

class FlowMaps extends StatefulWidget {
  FlowMaps() : super();

  final String title = "location";

  @override
  _FlowMapsState createState() => _FlowMapsState();
}

class _FlowMapsState extends State<FlowMaps> {
  Completer<GoogleMapController> _controller = Completer();
  static final LatLng _center = const LatLng(6.012484, 10.259225);
  final Set<Marker> flowMarkers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  GoogleMapController mapController;

  final Stream<QuerySnapshot> flowFirestoreStream =
      FirebaseFirestore.instance.collection('flow_water_sources').snapshots();

  Set<Marker> setMarkers() {
    return flowMarkers;
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  /// function to toggle between normal view and satellite view when the button is pressed
  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  /// function Add marker when the marker button is pressed
  /*_onAddMarkerButtonPressed() {
    setState(() {
      flowMarkers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
            infoWindow: InfoWindow(
            title: 'this is the title',
            snippet: 'this is the snipet',
          ),
        ),
      );
    });
  }*/

  /// button widget
  Widget button(
    Function function,
    //  IconData icon,
    String iconLink,
  ) {
    return FloatingActionButton(
      onPressed: function,
      //  materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.white,
      child: SvgPicture.asset(
        iconLink,
        color: primarycolor,
        height: 20,
      ),
    );
  }

  /// declaring variables for bottom sheet

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
              return BodyText(title: 'You are offline');
            default:
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                flowMarkers.add(
                  new Marker(
                    flat: false,
                    draggable: false,
                    markerId: MarkerId(snapshot.data.docs[i]['ID']),
                    position: LatLng(snapshot.data.docs[i]['location'].latitude,
                        snapshot.data.docs[i]['location'].longitude),
                    infoWindow: InfoWindow(
                      title: snapshot.data.docs[i]['ID'],
                    ),

                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return BottomSheetInfo(
                              bottomSheetID: snapshot.data.docs[i]['ID'],
                              bottomSheetDescription: snapshot.data.docs[i]
                                  ['description'],
                              bottomSheetisTypeTap: snapshot.data.docs[i]
                                  ['isTypeTap'],
                              bottomSheetisFlowing: snapshot.data.docs[i]
                                  ['isFlowing'],
                            );
                          });
                    }, //load bottom sheet
                  ),
                );
              }

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
                mapType: _currentMapType,
                markers: setMarkers(),
                onCameraMove: _onCameraMove,
                myLocationEnabled: true,

                //   onMapCreated: (GoogleMapController controller) {
                //      mapController = controller;
                //    },
              );
          }
        });
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
                ), // toggle map type botton
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
}
