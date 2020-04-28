import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:noobcaster/core/city_list.dart';
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
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(focusedBorder: InputBorder.none),
                  onSubmitted: (input) => _searchLocation(input, context),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  autofocus: true,
                ),
                suggestionsCallback: (text) =>
                    text.length > 0 ? _getCities(text) : null,
                itemBuilder: (context, suggestion) {
                  return Ink(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        color: Colors.white,
                        width: 2,
                      ),
                      title: Text(
                        suggestion,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    color: Colors.grey.shade900,
                  );
                },
                onSuggestionSelected: (suggestion) =>
                    _searchLocation(suggestion, context),
              ),
            ),
            SvgPicture.asset("assets/images/search.svg"),
          ],
        ),
      ),
    );
  }

  Iterable<String> _getCities(String text) {
    final results = cityList
        .where((city) =>
            RegExp(text, caseSensitive: false).matchAsPrefix(city) != null)
        .take(5);
    return results.length > 0 ? results : null;
  }

  void _searchLocation(String value, BuildContext context) {
    print("Submmited");
    BlocProvider.of<WeatherDataBloc>(context)
        .add(GetLocationWeatherEvent(value));
    Navigator.of(context).pop();
  }
}
