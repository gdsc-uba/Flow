import 'dart:core';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

Location location = Location();
PermissionStatus permissionStatus;
bool serviceEnabled;

///Checking if location service is enabled
Future<bool> checkServiceEnabled() async {
  serviceEnabled = await location.serviceEnabled();
  return serviceEnabled;
}

// requestServiceEnabled() async {
//   if (!serviceEnabled) {
//     serviceEnabled = await location.requestService();
//   }
// }
requestServiceEnabled() async {
  serviceEnabled = await location.requestService();
}

///Checking  if location permsissions have been granted
Future<PermissionStatus> getPermissionStatus() async {
  permissionStatus = await location.hasPermission();

  return permissionStatus;
}

requestPermissions() async {
  permissionStatus = await location.requestPermission();
}
