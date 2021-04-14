import 'package:flow/Components/bottom_sheet_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flow/Components/flow_app_bar.dart';
import 'package:flow/Components/search_bar.dart';
import 'package:flow/constants.dart';
import 'package:flow/Components/sources_list_item.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FlowFindScreen extends StatefulWidget {
  @override
  _FlowFindScreenState createState() => _FlowFindScreenState();
}

class _FlowFindScreenState extends State<FlowFindScreen> {
  /// creating a firestore Instance,
  final Stream<QuerySnapshot> flowFirestoreStream =
      FirebaseFirestore.instance.collection('flow_water_sources').snapshots();
  String ifisflowingiconlink;

  ///method to build a list for every document index in snapshot
  Widget buildWaterSourcesList(
      BuildContext context, DocumentSnapshot document) {
    if (document['isFlowing'] == true) {
      ifisflowingiconlink = 'Assets/icons/svgs/fi-sr-flowing-filled.svg';
    } else // add icon for when the tap is flowing
    {
      ifisflowingiconlink = 'Assets/icons/svgs/fi-rr-not-flowing.svg';
    }

    return WaterSourcesListItem(
      id: document['ID'],
      isflowingiconlink: ifisflowingiconlink,
      distance: 'N/A m',
      iconButtonWidget: IconButton(
          padding: EdgeInsets.zero,
          enableFeedback: true,
          icon: SvgPicture.asset(
            'Assets/icons/svgs/fi-rr-angle-small-down.svg',
            color: primarycolor,
          ),
          onPressed: () {
            setState(() {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return BottomSheetInfo(
                      bottomSheetID: document['ID'],
                      bottomSheetDescription: document['description'],
                      bottomSheetIsTypeTap: document['isTypeTap'],
                      bottomSheetIsFlowing: document['isFlowing'],
                    );
                  });
            });
          }),
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
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  //check for connection state and return appropriate messages
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
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
                        itemBuilder: (context, index) => buildWaterSourcesList(
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
