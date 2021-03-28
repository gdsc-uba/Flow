import 'package:location/location.dart';
import 'package:flutter/material.dart';

class MyLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  LocationData currentPosition;
  Location location = Location();

  /// declare variables here
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Latitude: ${currentPosition.latitude}, Longitude: ${currentPosition.longitude}",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// get location function
  getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    /// checking if location services have been enabled

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    /// checking if location permissions have been granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }

      ///this is where you exit app if permisions have been denied forever or
      ///request permissions
    }

    /// getting current position
    currentPosition = await location.getLocation();

    /// TO DO: set initial camera pos in the  maps file = currentPosition.latitude, currentPosition.longitude

    ///listening for location changes
    location.onLocationChanged.listen(
      (LocationData currentLocation) {
        setState(() {
          currentPosition = currentLocation;
          return currentLocation;
        });
      },
    );
  }
}
