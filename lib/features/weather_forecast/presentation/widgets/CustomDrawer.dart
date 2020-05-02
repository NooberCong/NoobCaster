import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noobcaster/core/Lang/language_handler.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/core/util/temp_converter.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:noobcaster/features/weather_forecast/domain/repositories/weather_repository.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_cached_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/presentation/bloc/weather_data_bloc.dart';
import 'package:noobcaster/injection_container.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.grey.shade900),
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Drawer(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: IconButton(
                      color: Theme.of(context).accentColor,
                      icon: FaIcon(FontAwesomeIcons.cog),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("/settings");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: GetCachedWeatherData(
                          repository: sl<WeatherRepository>())(NoParams()),
                      builder: _buildFuture)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFuture(BuildContext context,
      AsyncSnapshot<Either<Failure, Map<String, dynamic>>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.fold(
        (failure) => Expanded(
          child: Center(
            child: Text(
              translateNoData(),
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        (cachedData) => Expanded(
          child: Column(
            children: <Widget>[
              Text(
                translateMyLocation(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              CachedWeatherCard(
                data: cachedData["local"],
              ),
              Divider(
                color: Colors.grey[300],
                indent: 20,
                endIndent: 20,
                thickness: 0.2,
              ),
              Text(
                translateLastSearchedLocations(),
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: cachedData["location"].length,
                  itemBuilder: (context, index) => CachedWeatherCard(
                    data: cachedData["location"]
                        [cachedData["location"].length - index - 1],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }
}

class CachedWeatherCard extends StatelessWidget {
  final WeatherData data;
  const CachedWeatherCard({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _getDrawerWeatherData(context, data),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            data.isLocal
                ? Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 24,
                  )
                : SizedBox(),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                data.displayName,
                maxLines: 3,
                style: TextStyle(
                    color: data.isLocal ? Colors.blue : Colors.white,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/images/${data.icon}.svg",
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    tempFromUnit(data.currentTemp),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getDrawerWeatherData(BuildContext context, WeatherData cachedData) {
    if (cachedData.isLocal) {
      BlocProvider.of<WeatherDataBloc>(context).add(GetLocalWeatherEvent());
    } else {
      BlocProvider.of<WeatherDataBloc>(context)
          .add(GetLocationWeatherEvent(cachedData.displayName));
    }
    Navigator.of(context).pop(context);
  }
}
