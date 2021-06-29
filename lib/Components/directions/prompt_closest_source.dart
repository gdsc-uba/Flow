import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flow/Components/flow_location.dart';
import 'package:flow/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

final Stream<QuerySnapshot> flowFirestoreStream =
    FirebaseFirestore.instance.collection('flow_water_sources').snapshots();
LatLng markerLocation;
LatLng currentLocation;
double shortestDistance;
String closestSourceID;
String closestSourceDescription;
List<double> sourceDistancesList;

getLoc() async {
  LocationData currentLoc = await getLocation();

  currentLocation = LatLng(currentLoc.latitude, currentLoc.longitude);
  return currentLocation;
}

class ShowClosestSource extends StatelessWidget {
  final String id;
  final String description;
  final String distance;

  const ShowClosestSource({Key key, this.id, this.description, this.distance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      child: closestSourceDialogContent(),
    );
  }
}

Widget closestSourceDialogContent() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: primarycolor,
    ),
    height: 300,
    width: 300,
    child: Column(
      children: [
        Text('$closestSourceID} is closest to you, and marked as flowing'),
        Text('$shortestDistance Km'),
      ],
    ),
  );
}

// class ShowClosestSource extends StatefulWidget {
//   @override
//   _ShowClosestSourceState createState() => _ShowClosestSourceState();
// }
//
// class _ShowClosestSourceState extends State<ShowClosestSource> {
//   final Stream<QuerySnapshot> flowFirestoreStream =
//       FirebaseFirestore.instance.collection('flow_water_sources').snapshots();
//   LatLng markerLocation;
//   LatLng currentLocation;
//   double shortestDistance;
//   String closestSourceID;
//   String closestSourceDescription;
//   List<double> sourceDistancesList;
//
//   @override
//   void initState() {
//     super.initState();
//     getLoc();
//
//     //distanceCalculator(currentLocation, markerLocation);
//     //  ifTapIsSaved();
//   }
//
//   getLoc() async {
//     LocationData currentLoc = await getLocation();
//     setState(() {
//       currentLocation = LatLng(currentLoc.latitude, currentLoc.longitude);
//     });
//
//     return currentLocation;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: flowFirestoreStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         // calculatedDistances = [
//         //   distanceCalculator(currentLocation, markerLocation)
//         // ];
//         for (int i = 0; i < snapshot.data.docs.length; i++) {
//           markerLocation = LatLng(snapshot.data.docs[i]['location'].latitude,
//               snapshot.data.docs[i]['location'].longitude);
//
//           sourceDistancesList = [
//             getClosestSource(
//                 i, currentLocation, markerLocation, snapshot.data.docs[i]['ID'])
//           ];
//
//           ///sorting for the shortest distance
//
//           if (shortestDistance > sourceDistancesList[i]) {
//             shortestDistance = sourceDistancesList[i];
//             closestSourceID = snapshot.data.docs[i]['ID'];
//           }
//
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: primarycolor,
//                   ),
//                   height: 300,
//                   width: 300,
//                   child: Column(
//                     children: [
//                       Text(
//                           '$closestSourceID} is closest to you, and marked as flowing'),
//                       Text('$shortestDistance Km'),
//                     ],
//                   ),
//                 );
//               });
//         }
//
//         // ///sorting for the shortest distance
//         // for (int i = 0; i < sourceDistancesList.length; i++) {
//         //   if (shortestDistance > sourceDistancesList[i]) {
//         //     shortestDistance = sourceDistancesList[i];
//         //   }
//         // }
//         return;
//       },
//     );
//   }
// }
