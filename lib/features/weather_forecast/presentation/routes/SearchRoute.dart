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
                hideOnEmpty: true,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(focusedBorder: InputBorder.none),
                  onSubmitted: (input) => _searchLocation(input, context),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  autofocus: true,
                ),
                suggestionsCallback: (text) =>
                    text.length > 0 ? _getSuggestionText(text) : null,
                itemBuilder: (context, suggestion) {
                  return Ink(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        color: Colors.white,
                        width: 2,
                      ),
                      title: suggestion["widget"],
                    ),
                    color: Colors.grey.shade900,
                  );
                },
                onSuggestionSelected: (suggestion) =>
                    _searchLocation(suggestion["text"], context),
              ),
            ),
            SvgPicture.asset("assets/images/search.svg"),
          ],
        ),
      ),
    );
  }

  Iterable<Map<String, dynamic>> _getSuggestionText(String text) {
    return cityList
        .where((city) =>
            RegExp(text, caseSensitive: false).matchAsPrefix(city) != null)
        .take(10)
        .map(
          (match) => {
            "text": match,
            "widget": RichText(
              text: TextSpan(
                text: match.substring(0, text.length),
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: match.substring(text.length),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          },
        );
  }

  void _searchLocation(String value, BuildContext context) {
    BlocProvider.of<WeatherDataBloc>(context)
        .add(GetLocationWeatherEvent(value));
    Navigator.of(context).pop();
  }
}
