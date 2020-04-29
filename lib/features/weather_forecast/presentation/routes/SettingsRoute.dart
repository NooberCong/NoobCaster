import 'package:flutter/material.dart';

class SettingsRoute extends StatelessWidget {
  const SettingsRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey.shade900,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Temperature unit\n",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.grey.shade900,
                      ),
                      child: DropdownButton(
                        underline: SizedBox(),
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "°C",
                              style: TextStyle(color: Colors.blue),
                            ),
                            value: "°C",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "°F",
                              style: TextStyle(color: Colors.blue),
                            ),
                            value: "°F",
                          ),
                        ],
                        onChanged: (newValue) => null,
                        value: "°C",
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
