import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(data);

    //set background
    String bgImage = data['isDayTime'] ? 'daytime.png' : 'nighttime.png';
    Color bgColor = data['isDayTime'] ? Colors.lightBlue[600]! : Colors.black;

    print(data['datetime']);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                     dynamic result = await Navigator.pushNamed(context, '/location');
                     setState(() {
                       data = {
                         'time': result['time'],
                         'location': result['location'],
                         'isDayTime': result['isDayTime'],
                         'flag': result['flag'],
                         'timezone': result['timezone'],
                         'weekday': result['weekday'],
                         'week_number': result['week_number'],
                         'day_of_year': result['day_of_year'],
                         'date': result['date'],
                       };
                     });
                  },
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  )
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 130.0),
                Text(
                  'KW ${data['week_number'].toString()}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  data['weekday'],
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  data['date'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 50.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 80.0),
                CircularPercentIndicator(
                  backgroundColor: Colors.transparent,
                  radius: 50.0,
                  lineWidth: 12.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: data['day_of_year'] / 365,
                  center: Text(
                    '${(data['day_of_year'] / 365 * 100).toStringAsFixed(1)} %',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.white,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
