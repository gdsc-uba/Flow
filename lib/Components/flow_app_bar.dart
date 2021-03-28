import 'package:flutter/material.dart';

class FlowAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  FlowAppBar({
    Key key,
  })  : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Image(
            image: AssetImage('Assets/images/flow_logo.png'),
          ),
        ),
      ),
      leadingWidth: double.infinity,
    );
  }
}
