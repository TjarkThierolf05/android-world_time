import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';
  String weekday = 'loading';
  String region = 'loading';
  String city = 'loading';
  String week_number = 'loading';
  String day_of_year = 'loading';


  void setupWorldTime() async {
    WorldTime beispiel = WorldTime(location: "Berlin", flag: "germany.png", url: "Europe/Berlin");
    await beispiel.getAPIresponse();

    await beispiel.getTime();
    print(beispiel.time);
    setState(() {time = beispiel.time;});

    await Future.delayed(const Duration(seconds: 2));
    await beispiel.getWeekday();
    print(beispiel.weekday);
    setState(() {weekday = beispiel.weekday;});

    await Future.delayed(const Duration(seconds: 2));
    await beispiel.getTimezone();
    print(beispiel.timezone[0]);
    print(beispiel.timezone[1]);
    setState(() {
      region = beispiel.timezone[0];
      city = beispiel.timezone[1];
    });

    await Future.delayed(const Duration(seconds: 2));
    await beispiel.getWeekNumber();
    print(beispiel.week_number);
    setState(() {week_number = beispiel.week_number.toString();});

    await Future.delayed(const Duration(seconds: 2));
    await beispiel.getDayOfYear();
    print(beispiel.day_of_year);
    setState(() {day_of_year = beispiel.day_of_year.toString();});
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(time),
            Text(weekday),
            Text(region),
            Text(city),
            Text(week_number),
            Text(day_of_year),
          ],
        ),
      ),
    );
  }
}
