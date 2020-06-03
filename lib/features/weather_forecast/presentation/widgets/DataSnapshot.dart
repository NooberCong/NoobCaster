import 'package:flutter/material.dart';

class DataSnapshot extends StatelessWidget {
  final String textUpper;
  final String textLower;
  final dynamic icon;
  const DataSnapshot({
    Key key,
    @required this.textUpper,
    @required this.textLower,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        icon as Widget,
        Text(
          "$textUpper\n$textLower",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
