import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flow/Components/flow_app_bar.dart';
import 'package:flow/Components/search_bar.dart';
import 'package:flow/constants.dart';
import 'package:flow/Components/sources_list_item.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FlowFindScreen extends StatelessWidget {
  /// creating a firestore Instance,
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Stream<QuerySnapshot> flowFirestoreStream =
      FirebaseFirestore.instance.collection('flow_water_sources').snapshots();

  String ifisflowingiconlink;

  ///method to build a list for every doucment index in snapshot
  Widget BuildWaterSourcesList(
      BuildContext context, DocumentSnapshot document) {
    // this if statement does not work well
    if (document['isFlowing'] == true) {
      ifisflowingiconlink = 'Assets/icons/svgs/fi-rr-flowing.svg';
    } else // add icon for when the tap is flowing
    {
      ifisflowingiconlink = 'Assets/icons/svgs/fi-rr-not-flowing.svg';
    }
    return WaterSourcesListItem(
      id: document['ID'],
      isflowingiconlink: ifisflowingiconlink,
      distance: 'N/A m',
    );
  }

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: FlowAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: StreamBuilder(
                stream: flowFirestoreStream,
                builder: (BuildContextcontext,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  //check for connection state and return appropriate messages
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      );
                    case ConnectionState.none:
                      return BodyText(title: 'You are offline');

                    //this is the data we get
                    default:
                      List<DocumentSnapshot> flowDocuments = snapshot.data.docs;

                      return ListView.builder(
                        itemExtent: 50,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) => BuildWaterSourcesList(
                            context, snapshot.data.docs[index]),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),

      // SearchBar(),
    );
  }
}
