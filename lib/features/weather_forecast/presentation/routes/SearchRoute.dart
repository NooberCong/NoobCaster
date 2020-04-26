import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noobcaster/features/weather_forecast/presentation/bloc/weather_data_bloc.dart';

class SearchRoute extends StatelessWidget {
  SearchRoute({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(focusedBorder: InputBorder.none),
                onSubmitted: (input) => _searchLocation(input, context),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                autofocus: true,
                enableSuggestions: true,
              ),
            ),
            SvgPicture.asset("assets/images/search.svg"),
          ],
        ),
      ),
    );
  }

  void _searchLocation(String value, BuildContext context) {
    print("Submmited");
    BlocProvider.of<WeatherDataBloc>(context)
        .add(GetLocationWeatherEvent(value));
    Navigator.of(context).pop();
  }
}
