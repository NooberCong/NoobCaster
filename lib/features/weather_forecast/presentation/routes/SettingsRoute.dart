import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobcaster/core/settings/app_settings.dart';
import 'package:noobcaster/features/weather_forecast/presentation/bloc/weather_data_bloc.dart';
import 'package:noobcaster/injection_container.dart';

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({Key key}) : super(key: key);

  @override
  _SettingsRouteState createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
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
          color: Colors.grey.shade900,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SettingCard(
                title: "Temperature unit",
                action: DropdownButton(
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
                  onChanged: (value) {
                    _setTempUnit(value);
                    _reloadBlocState(context);
                    _rerender();
                  },
                  value: _getTempConfig(),
                ),
              ),
              Divider(
                color: Colors.grey.shade700,
                indent: 20,
                endIndent: 20,
              ),
              SettingCard(
                title: "Locality",
                action: DropdownButton(
                  underline: SizedBox(),
                  items: _generateLocaleMenuItems(),
                  onChanged: (value) {
                    _setLocale(value);
                    _reloadBlocState(context);
                    _rerender();
                  },
                  value: _getLocaleConfig(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _reloadBlocState(BuildContext context) {
    BlocProvider.of<WeatherDataBloc>(context).add(ReloadStateEvent(
        currentState: BlocProvider.of<WeatherDataBloc>(context).state));
  }

  void _setTempUnit(String value) {
    sl<AppSettings>().setTempUnit(value);
  }

  void _setLocale(value) {
    sl<AppSettings>().setLocale(value);
  }

  String _getTempConfig() {
    return sl<AppSettings>().getTempUnit();
  }

  String _getLocaleConfig() {
    return sl<AppSettings>().getLocale();
  }

  void _rerender() {
    setState(() {});
  }

  List<DropdownMenuItem> _generateLocaleMenuItems() {
    return Locales.map(
      (locale) => DropdownMenuItem(
        value: locale,
        child: Text(
          locale,
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ).toList();
  }
}

class SettingCard extends StatelessWidget {
  final String title;
  final Widget action;
  const SettingCard({
    Key key,
    @required this.title,
    @required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      trailing: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey.shade900,
        ),
        child: action,
      ),
    );
  }
}
