import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noobcaster/core/Lang/language_handler.dart';
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
  double dataMax;
  @override
  void initState() {
    dataMax = T == HourlyWeatherData
        ? _getMaxTemp(widget.data as List<HourlyWeatherData>)
        : _getMaxRange(widget.data as List<DailyWeatherData>);
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
          height: 250,
          width: double.infinity,
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
                          maxTemp: dataMax);
                    } else {
                      return DailyForecastColumn(
                          data: (widget.data[index] as DailyWeatherData),
                          maxRange: dataMax);
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

  double _getMaxRange(List<DailyWeatherData> data) {
    return data
        .map((day) => day.maxTemp - day.minTemp)
        .toList()
        .reduce(math.max);
  }

  double _getMaxTemp(List<HourlyWeatherData> data) {
    return data.map((hour) => hour.temp).toList().reduce(math.max);
  }
}

String _getSnapshotDescription<T>(int length) {
  if (T == HourlyWeatherData) {
    return translateHour();
  } else {
    return translateDay();
  }
}

class HourlyForecastColumn extends StatelessWidget {
  final double maxTemp;
  final HourlyWeatherData data;
  const HourlyForecastColumn(
      {Key key, @required this.data, @required this.maxTemp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            formattedHour(data.hour),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SvgPicture.asset("assets/images/${data.icon}.svg",
              height: 50, width: 50),
          TempVisualizer(temp: data.temp, max: maxTemp),
        ],
      ),
    );
  }
}

class TempVisualizer extends StatelessWidget {
  final double temp;
  final double max;
  const TempVisualizer({Key key, @required this.temp, @required this.max})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            tempFromUnit(temp),
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
            height: math.max(60 - 5 * (max - temp), 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

class DailyForecastColumn extends StatelessWidget {
  final DailyWeatherData data;
  final double maxRange;
  const DailyForecastColumn(
      {Key key, @required this.data, @required this.maxRange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(translateWeekDay(data.weekday),
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SvgPicture.asset("assets/images/${data.icon}.svg",
              width: 50, height: 50),
          TempRangeVisualizer(
            maxTemp: data.maxTemp,
            minTemp: data.minTemp,
            max: maxRange,
          ),
        ],
      ),
    );
  }
}

class TempRangeVisualizer extends StatelessWidget {
  final double minTemp;
  final double maxTemp;
  final double max;
  const TempRangeVisualizer(
      {Key key,
      @required this.minTemp,
      @required this.maxTemp,
      @required this.max})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(tempFromUnit(maxTemp),
              style: TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              width: 5,
              height: math.max(50 - 6 * (max - (maxTemp - minTemp)), 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(tempFromUnit(minTemp),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        ],
      ),
    );
  }
}
