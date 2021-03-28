import 'package:flow/Models/flow_firebase_data_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTest extends StatelessWidget {
  //creating A firestore instance
  final Stream<QuerySnapshot> flowFirestoreStream =
      FirebaseFirestore.instance.collection('flow_water_sources').snapshots();
  final FlowFirebaseData flowFirestoreData;
  FirebaseTest({this.flowFirestoreData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: flowFirestoreStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            //check for connection state and return appropriate messages
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.none:
                return Text('You are offline');

              //this is the data we get
              default:
                List<DocumentSnapshot> flowDocuments = snapshot.data.docs;

                return ListView(
                    children: flowDocuments.map((DocumentSnapshot document) {
                  FlowFirebaseData(
                    id: document['ID'.toString()],
                    location: document['location'],
                    description: document['description'],
                    isClean: document['isClean'],
                    isTypeTap: document['isTypeTap'],
                  );
                }).toList());

              /*   return ListView(
                  key: GlobalKey(),
                  children: flowDocuments.map((DocumentSnapshot document) {
                    return Text(document['description']);
                  }).toList(),
                );*/
            }
          }),
    );
  }
}

/*class FlowFirebaseData extends StatelessWidget {
  final String id;
  final GeoPoint location;
  final String description;
  final bool isClean; //portable or not portable
  final bool isTypeTap; //tap or stream
  FlowFirebaseData(
      {this.id, this.location, this.description, this.isClean, this.isTypeTap});

  @override
  Widget build(BuildContext context) {
    return null;
  }
}*/
