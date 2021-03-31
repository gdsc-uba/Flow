import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences prefs;
// Future<bool> sourceID(List<String> sourceID) async {
//   prefs = await SharedPreferences.getInstance();
//   prefs.setStringList(
//     'sourceID',
//   );
// }
initialiseSP() async {
  SharedPreferences FlowSharedPreferences =
      await SharedPreferences.getInstance();
}

class flowSharedPrefs {
  String sourceID;
  String sourceDescription;
  double sourceDistance;
  bool sourceTypeTap;
  bool sourceFlowing;

  flowSharedPrefs({
    this.sourceDescription,
    this.sourceDistance,
    this.sourceFlowing,
    this.sourceID,
    this.sourceTypeTap,
  });

  ///convert from map/List to flowSharedPrefs obj
  flowSharedPrefs.fromMap(Map<String, dynamic> map) {
    this.sourceID = map['sourceID'];
    this.sourceDescription = map['sourceDescription'];
    this.sourceDistance = map['sourceDistance'];
    this.sourceFlowing = map['sourceFlowing'];
    this.sourceTypeTap = map['sourceTypeTap'];
  }

  ///convert from flowSharedPrefs obj to map/List
  Future<Map> toMap() async {
    return {
      'sourceID': this.sourceID,
      'sourceDescription': this.sourceDescription,
      'sourceDistance': this.sourceDistance,
      'sourceFlowing': this.sourceFlowing,
      'sourceTypeTap': this.sourceTypeTap,
    };
    // }
  }
}
