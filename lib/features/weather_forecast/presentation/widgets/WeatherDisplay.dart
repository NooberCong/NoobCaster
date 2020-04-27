import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noobcaster/core/util/description_formatter.dart';
import 'package:noobcaster/core/util/temp_converter.dart';
import 'package:noobcaster/core/util/time_converter.dart';
import 'package:noobcaster/core/util/uvi_evaluator.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/DataSnapshot.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/DetailsSnapshot.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/ForecastSnapshot.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherData data;
  const WeatherDisplay({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "${data.displayName}\n",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: formattedTime(data.dateTime),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ]),
        ),
        SizedBox(
          height: 20,
        ),
        SvgPicture.asset(
          "assets/images/${data.icon}.svg",
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width / 3,
        ),
        SizedBox(
          height: 20,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "${toCelcius(data.currentTemp)}\n",
            style: TextStyle(
              color: Colors.white,
              fontSize: 70,
              fontWeight: FontWeight.w100,
            ),
            children: [
              TextSpan(
                text: formatDescription(data.description),
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DataSnapshot(
                textUpper: "Uv level",
                textLower: "${getUviLevel(data.uvi)}",
                icon: FaIcon(
                  FontAwesomeIcons.sun,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              DataSnapshot(
                textUpper: "Wind",
                textLower: "${data.windspeed}m/s",
                icon: FaIcon(
                  FontAwesomeIcons.wind,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              DataSnapshot(
                textUpper: "Humidity",
                textLower: "${data.humidity}%",
                icon: FaIcon(
                  FontAwesomeIcons.tint,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
        ),
        ForecastSnapshot<HourlyWeatherData>(
          data: data.hourly,
        ),
        SizedBox(
          height: 20,
        ),
        ForecastSnapshot<DailyWeatherData>(
          data: data.daily,
        ),
        SizedBox(
          height: 20,
        ),
        DetailsSnapshot(
          data: data,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                (data.isCached ? "Cached " : "Updated ") +
                    formattedTime(data.dateTime),
                style: TextStyle(color: Colors.white, fontSize: 12),
              )),
        )
      ],
    );
  }
}
