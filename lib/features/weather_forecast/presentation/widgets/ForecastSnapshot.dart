import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noobcaster/core/util/temp_converter.dart';
import 'package:noobcaster/core/util/time_converter.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';

class ForecastSnapshot<T> extends StatefulWidget {
  final List<T> data;
  const ForecastSnapshot({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  @override
  _ForecastSnapshotState<T> createState() => _ForecastSnapshotState<T>();
}

class _ForecastSnapshotState<T> extends State<ForecastSnapshot<T>> {
  bool showLeftScroll = false;
  bool showRightScroll = true;
  @override
  void initState() {
    _controller.addListener(() {
      if (!_controller.position.atEdge) {
        if (!showLeftScroll || !showRightScroll) {
          setState(() {
            showLeftScroll = true;
            showRightScroll = true;
          });
        }
      } else {
        if (_controller.offset >= _controller.position.maxScrollExtent) {
          if (showRightScroll) {
            setState(() {
              showRightScroll = false;
            });
          }
        } else {
          if (showLeftScroll) {
            setState(() {
              showLeftScroll = false;
            });
          }
        }
      }
    });
    super.initState();
  }

  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, bottom: 20),
          child: Text(
            _getSnapshotDescription<T>(widget.data.length),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey[300].withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              showLeftScroll
                  ? GestureDetector(
                      onTap: () =>
                          _scrollToStartWithDynamicDuration(widget.data.length),
                      child: Container(
                        child: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).accentColor,
                          size: 30,
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 30,
                    ),
              Expanded(
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    if (T == HourlyWeatherData) {
                      return HourlyForecastColumn(
                        data: (widget.data[index] as HourlyWeatherData),
                      );
                    } else {
                      return DailyForecastColumn(
                        data: (widget.data[index] as DailyWeatherData),
                      );
                    }
                  },
                ),
              ),
              showRightScroll
                  ? GestureDetector(
                      onTap: () =>
                          _scrollToEndWithDynamicDuration(widget.data.length),
                      child: Container(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).accentColor,
                          size: 30,
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 30,
                    ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToEndWithDynamicDuration(int length) {
    _controller.position.animateTo(_controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 50 * length), curve: Curves.easeInOut);
  }

  void _scrollToStartWithDynamicDuration(int length) {
    _controller.position.animateTo(_controller.position.minScrollExtent,
        duration: Duration(milliseconds: 50 * length), curve: Curves.easeInOut);
  }
}

String _getSnapshotDescription<T>(int length) {
  if (T == HourlyWeatherData) {
    return "Hourly ($length hours)";
  } else {
    return "Daily ($length days)";
  }
}

class HourlyForecastColumn extends StatelessWidget {
  final HourlyWeatherData data;
  const HourlyForecastColumn({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            getHourFromUnix(data.unixtime),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SvgPicture.asset("assets/images/${data.icon}.svg",
              height: 50, width: 50),
          TempVisualizer(temp: data.temp),
        ],
      ),
    );
  }
}

class TempVisualizer extends StatelessWidget {
  final double temp;
  const TempVisualizer({Key key, @required this.temp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          toCelcius(temp),
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 5,
          height: temp / 7.5,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}

class DailyForecastColumn extends StatelessWidget {
  final DailyWeatherData data;
  const DailyForecastColumn({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(getDayOfWeekFromUnix(data.unixtime),
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SvgPicture.asset("assets/images/${data.icon}.svg",
              width: 50, height: 50),
          TempRangeVisualizer(
            maxTemp: data.maxTemp,
            minTemp: data.minTemp,
          ),
        ],
      ),
    );
  }
}

class TempRangeVisualizer extends StatelessWidget {
  final double minTemp;
  final double maxTemp;
  const TempRangeVisualizer(
      {Key key, @required this.minTemp, @required this.maxTemp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(toCelcius(maxTemp),
            style: TextStyle(color: Colors.white, fontSize: 18)),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 5,
          height: max(maxTemp - minTemp, 5.0) * 4,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(toCelcius(minTemp),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            )),
      ],
    );
  }
}
