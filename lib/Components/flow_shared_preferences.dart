import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FlowSaved {
  String savedID;
  String savedDescription;
  String savedDistance;
  bool savedFlowing;
  String savedTypeTap;
  GeoPoint savedTapLocation;
  //bool savedisSaved;

  FlowSaved({
    this.savedID,
    this.savedDescription,
    this.savedDistance,
    this.savedFlowing,
    this.savedTypeTap,
    this.savedTapLocation,
    // this.savedisSaved,
  });

  ///convert from map to flowSaved object
  FlowSaved.fromMap(Map map)
      : this.savedID = map[
            'ID'], // assigning ths SavedID from the constructor to the 'ID' property/Variable of our map
        this.savedDescription = map['Description'],
        this.savedDistance = map['Distance'],
        this.savedFlowing = map['Flowing'],
        this.savedTypeTap = map['TypeTap'],
        this.savedTapLocation = map['Location'];
  //  this.savedisSaved = map['isSaved'];

  ///convert from flowSaved Object to a map
  Map toMap() {
    return {
      'ID': this.savedID,
      'Description': this.savedDescription,
      'Distance': this.savedDistance,
      'Flowing': this.savedFlowing,
      'TypeTap': this.savedTypeTap,
      'Location': this.savedTapLocation,
      // 'isSaved': this.savedisSaved,
    };
  }
}
