import 'package:flow/Components/flow_bottom_nav_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flow/Components/flow_location.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/AskingPermissions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flow',
        theme: ThemeData(
          fontFamily: 'Product Sans',
          scaffoldBackgroundColor: Colors.grey[200],
          canvasColor: Colors.transparent,
        ),

         home: FlowBottomNavBar(),
        //home: FlowAskPermissions()
        // home: FlowAskPermissions(),
        //home: FirebaseTest(),
        // home: FlowSourcesBottomSheet(),
        //home: MyLocation(),
        );
  }
}
