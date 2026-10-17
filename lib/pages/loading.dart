import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    WorldTime beispiel = WorldTime(location: "Berlin", flag: "germany.png", url: "Europe/Berlin");
    await beispiel.getAPIresponse();

    await beispiel.getTime();
    //print(beispiel.time);
    //setState(() {time = beispiel.time;});
//
    //await Future.delayed(const Duration(seconds: 2));
    await beispiel.getWeekday();
    //print(beispiel.weekday);
    //setState(() {weekday = beispiel.weekday;});
//
    //await Future.delayed(const Duration(seconds: 2));
    await beispiel.getTimezone();
    //print(beispiel.timezone[0]);
    //print(beispiel.timezone[1]);
    //setState(() {
    //  region = beispiel.timezone[0];
    //  city = beispiel.timezone[1];
    //});
//
    //await Future.delayed(const Duration(seconds: 2));
    await beispiel.getWeekNumber();
    //print(beispiel.week_number);
    //setState(() {week_number = beispiel.week_number.toString();});
//
    //await Future.delayed(const Duration(seconds: 2));
    await beispiel.getDayOfYear();
    //print(beispiel.day_of_year);
    //setState(() {day_of_year = beispiel.day_of_year.toString();});

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': beispiel.location,
      'flag': beispiel.flag,
      'time': beispiel.time,
      'isDayTime': beispiel.isDayTime,
      'timezone': beispiel.timezone,
      'weekday': beispiel.weekday,
      'week_number': beispiel.week_number,
      'day_of_year': beispiel.day_of_year,
      'date': beispiel.date,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
