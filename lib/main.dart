import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/ActionBar.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/ErrorDisplay.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/WeatherDisplay.dart';
import 'package:noobcaster/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noobcaster/features/weather_forecast/presentation/bloc/weather_data_bloc.dart';
import 'package:noobcaster/injection_container.dart' as di;
import 'package:noobcaster/route_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherDataBloc>(
      create: (_) => sl<WeatherDataBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(fontFamily: "OpenSans", accentColor: Color(0xffAEAEAE)),
        onGenerateRoute: generateRoute,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.grey.shade900),
        child: SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Drawer(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      color: Theme.of(context).accentColor,
                      icon: FaIcon(FontAwesomeIcons.cog),
                      onPressed: () {},
                    ),
                    Row(
                      children: <Widget>[],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ActionBar(),
        ),
        Positioned(
          top: 86,
          bottom: 0,
          right: 0,
          left: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: RefreshIndicator(
              onRefresh: () => Future.value(null),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    BlocBuilder<WeatherDataBloc, WeatherDataState>(
                      builder: (context, state) {
                        if (state is WeatherDataInitial) {
                          BlocProvider.of<WeatherDataBloc>(context)
                              .add(GetLocalWeatherEvent());
                          return SizedBox();
                        } else if (state is WeatherDataLoading) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 2 -
                                    246),
                            child: CupertinoActivityIndicator(
                              animating: true,
                              radius: 15.0,
                            ),
                          );
                        } else if (state is WeatherDataLoaded) {
                          return WeatherDisplay(
                            data: state.data,
                          );
                        } else if (state is WeatherDataError) {
                          return ErrorDisplay(message: state.message);
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
