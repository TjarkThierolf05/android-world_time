import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  String location; // location name for the UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint

  late Map data;
  late String weekday;
  late List timezone;
  late int week_number;
  late int day_of_year;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<Map> getAPIresponse() async {
    Response response =  await get(Uri.parse('https://worldtime.timezone.io/api/timezone/$url'));
    data = jsonDecode(response.body);
    return data;
  }

  Future<void> getTime() async {

    try {
      // make the request
      String datetime = data["datetime"];
      String utc_offset = data["utc_offset"];

      String offset_posneg = utc_offset.substring(0, 1);
      String offset_hours = utc_offset.substring(1,3);
      String offset_minutes = utc_offset.substring(4,6);

      DateTime now = DateTime.parse(datetime);

      //print(datetime);
      //print(utc_offset);
      //print(offset_posneg);
      //print(offset_hours);
      //print(offset_minutes);

      if (offset_posneg == "+") {
        now = now.add(Duration(hours: int.parse(offset_hours)));
        now = now.add(Duration(minutes: int.parse(offset_minutes)));
        time = now.toString(); // set the time property
      }
      else if (offset_posneg == "-") {
        now = now.subtract(Duration(hours: int.parse(offset_hours)));
        now = now.add(Duration(minutes: int.parse(offset_minutes)));
        time = now.toString(); // set the time property
      }
      else {
      }

      print("Date: " + now.toString().substring(0, 10));
      print("Time: " + now.toString().substring(11, 19));
      print("Offset: " + utc_offset);
    }
    catch (e) {
      print('Caught error: $e');
      time = "could not get time data";
    }
  }

  Future<String> getWeekday() async {

    List DayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    try {
      int day_of_week = data["day_of_week"];
      weekday = DayNames[day_of_week-1];
      return weekday;
    }
    catch (e) {
      print('Caught error: $e');
      weekday = "-";
      return weekday;
    }
  }

  Future<List> getTimezone() async {

    try {
      String zone = data["timezone"];
      timezone = zone.split("/");
      return timezone;
    }
    catch (e) {
      print('Caught error: $e');
      timezone = ['-', '-'];
      return timezone;
    }
  }

  Future<int> getWeekNumber() async {
    try {
      week_number = data["week_number"];
      return week_number;
    }
    catch (e) {
      print('Caught error: $e');
      week_number = 0;
      return week_number;
    }
  }

  Future<int> getDayOfYear() async {
    try {
      day_of_year = data["day_of_year"];
      return day_of_year;
    }
    catch (e) {
      print('Caught error: $e');
      day_of_year = 0;
      return day_of_year;
    }

  }

}