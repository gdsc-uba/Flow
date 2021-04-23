import 'package:flow/Components/Permissions.dart';
import 'package:flow/Components/flow_bottom_nav_bar.dart';
import 'package:flow/Screens/FlowAskPermissionsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flow/Components/flow_app_bar.dart';
import 'package:flow/Screens/FlowAskEnableLocationScreen.dart';
import 'package:flow/Components/flow_maps.dart';
import 'package:location/location.dart';

class FlowHomeScreen extends StatefulWidget {
  @override
  _FlowHomeScreenState createState() => _FlowHomeScreenState();
}

class _FlowHomeScreenState extends State<FlowHomeScreen> {
  Location location = Location();

  // @override
  // void initState() {
  //   getPermissionStatus();
  //   checkServiceEnabled();
  //   super.initState();
  // }

  Future<void> checkPermissionStatus() async {
    PermissionStatus currentPermissionStatus = await getPermissionStatus();

    // print(
    //     'permission  in check perm func from permisssion page getpermstat func without await is : ${getPermissionStatus()}');

    print(
        'permission  in check perm func from permisssion page getpermstat func is : ${await getPermissionStatus()}');

    if (currentPermissionStatus != PermissionStatus.granted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (BuildContext context) => FlowAskPermissions()),
        );
      });
    }
  }

  Future<void> checkIfServiceEnabled() async {
    bool serviceEnabledStatus = await checkServiceEnabled();

    // print(
    //     'wether service enabled status from permission page is without await is : ${checkServiceEnabled()}');

    print(
        'wether enabled status from permission page is : ${await checkServiceEnabled()}');

    if (serviceEnabledStatus != true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (BuildContext context) => FlowAskEnableLocation()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      checkPermissionStatus();
      checkIfServiceEnabled();
    });

    return Scaffold(
      appBar: FlowAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            FlowMaps(),
            // SearchBar(),
          ],
        ),
      ),
      //  bottomNavigationBar: FlowBottomNavBar(),
    );
  }
}
