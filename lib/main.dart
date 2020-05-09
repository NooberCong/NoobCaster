import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/ActionBar.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/CustomDrawer.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/ErrorDisplay.dart';
import 'package:noobcaster/features/weather_forecast/presentation/widgets/WeatherDisplay.dart';
import 'package:noobcaster/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noobcaster/features/weather_forecast/presentation/bloc/weather_data_bloc.dart';
import 'package:noobcaster/injection_container.dart' as di;
import 'package:noobcaster/route_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        theme: ThemeData(
          fontFamily: "OpenSans",
          accentColor: Color(0xffAEAEAE),
          hintColor: Colors.grey.shade600,
        ),
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
      drawer: CustomDrawer(),
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
          child: BlocBuilder<WeatherDataBloc, WeatherDataState>(
            builder: (context, state) {
              if (state is WeatherDataInitial) {
                BlocProvider.of<WeatherDataBloc>(context)
                    .add(GetLocalWeatherEvent());
                return SizedBox();
              } else if (state is WeatherDataLoading) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 50.5),
                  child: Center(
                    child: CircularProgressIndicator(
                    ),
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
        ),
      ],
    );
  }
}
