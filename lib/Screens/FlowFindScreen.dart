import 'package:flow/Components/bottom_sheet_info.dart';
import 'package:flow/Components/flow_snackbar.dart';
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
  Color flowingColor;
  String descriptionSnippet;

  ///method to build a list for every document index in snapshot
  Widget buildWaterSourcesList(
      BuildContext context, DocumentSnapshot document) {
    if (document['isFlowing'] == true) {
      ifisflowingiconlink = 'Assets/icons/svgs/fi-sr-flowing-filled.svg';
      flowingColor = primarycolor;
    } else // add icon for when the tap is flowing
    {
      ifisflowingiconlink = 'Assets/icons/svgs/fi-rr-not-flowing.svg';
      flowingColor = textcolor;
    }
    if (document['description'].toString().length < 20) {
      descriptionSnippet = document['description'];
    } else {
      descriptionSnippet = document['description'].toString().substring(0, 20);
    }

    return WaterSourcesListItemFindScreen(
      id: document['ID'],
      isflowingiconlink: ifisflowingiconlink,
      flowIconColor: flowingColor,
      description: '$descriptionSnippet...',
      moreInfoIcon: IconButton(
          padding: EdgeInsets.zero,
          enableFeedback: true,
          icon: SvgPicture.asset(
            'Assets/icons/svgs/fi-rr-angle-small-down.svg',
            color: textcolor,
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
                      tapLocation: document['location'],
                    );
                  });
            });
          }),
      iconButtonWidget: SizedBox(
        width: 1,
      ),
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
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 16),
              child: Text(
                'Water Sources',
                style: TextStyle(
                  color: primarycolor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: StreamBuilder(
                stream: flowFirestoreStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    //return Text('Error: ${snapshot.error}');
                    return FlowSnackBar(text: 'Error: ${snapshot.error}');
                  }
                  //check for connection state and return appropriate messages
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.transparent,
                        ),
                      );
                    case ConnectionState.none:
                      //return BodyText(title: 'You are offline');
                      return FlowSnackBar(
                        text: 'Oops, You are offline',
                      );

                    //this is the data we get
                    default:
                      List<DocumentSnapshot> flowSourcesDocuments =
                          snapshot.data.docs;

                      return ListView.builder(
                        itemExtent: 50,
                        itemCount: flowSourcesDocuments.length,
                        itemBuilder: (context, index) => buildWaterSourcesList(
                            context, flowSourcesDocuments[index]),
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
