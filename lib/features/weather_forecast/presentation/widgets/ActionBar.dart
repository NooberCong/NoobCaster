import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: FaIcon(
              FontAwesomeIcons.bars,
              color: Colors.white,
              size: 26,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/search");
            },
            icon: FaIcon(
              FontAwesomeIcons.searchLocation,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
