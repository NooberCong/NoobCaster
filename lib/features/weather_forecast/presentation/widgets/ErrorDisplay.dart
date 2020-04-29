import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  const ErrorDisplay({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
        ),
      ),
    );
  }
}
