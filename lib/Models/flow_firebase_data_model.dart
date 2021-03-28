import 'package:cloud_firestore/cloud_firestore.dart';

class FlowFirebaseData {
  final String id;
  final GeoPoint location;
  final String description;
  final bool isClean; //portable or not portable
  final bool isTypeTap;
  final bool isflowing; //tap or stream
  FlowFirebaseData({
    this.id,
    this.location,
    this.description,
    this.isClean,
    this.isTypeTap,
    this.isflowing,
  });
}
