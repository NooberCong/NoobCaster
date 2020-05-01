import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noobcaster/core/Lang/language_handler.dart';
import 'package:noobcaster/core/util/time_converter.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';

class DetailsSnapshot extends StatelessWidget {
  final WeatherData data;
  const DetailsSnapshot({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, bottom: 20),
          child: Text(
            translateDetails(),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[300].withOpacity(0.2),
          ),
          child: Column(
            children: <Widget>[
              DetailBar(
                data: data.uvi.toString(),
                label: "UV",
                icon: "uv-details",
              ),
              DetailBar(
                data: formattedHourAndMinute(data.sunrise),
                label: translateSunrise(),
                icon: "sunrise-details",
              ),
              DetailBar(
                data: formattedHourAndMinute(data.sunset),
                label: translateSunset(),
                icon: "sunset-details",
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DetailBar extends StatelessWidget {
  final String icon;
  final String label;
  final dynamic data;
  const DetailBar({
    Key key,
    @required this.data,
    @required this.icon,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset("assets/images/$icon.svg", width: 50, height: 50),
            Text(
              "\t\t$label",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          data,
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }
}
