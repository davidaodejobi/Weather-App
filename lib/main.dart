import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import "dart:math";

const kDefaultPadding = 20.0;

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Color(0xFFD5D6D7),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //a list to display some tips to the users
  var tipList = [
    'When a thunderstorm threatens, protect yourself by taking cover within your home, a large building, or a hard-topped automobile. Do not use the phone except in the case of an emergency.',
    'In the case of a flash flood event, stay out and away from deep water.',
    'Just like you need to take breaks from your work throughout the day, your body needs to take breaks from the cold. Plan warm-up times throughout your day to avoid numbness and shivers.',
    'Working outdoors can be challenging, and increases risks to your safety. Make sure you’re getting enough sleep to stay alert on the job when conditions are more dangerous. '
  ];

  //a function to iterate between the list and randomise the list
  getRandomElement<tip_list>(List<tip_list> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  //dynamic variable to hold the data that will be retrieve from the api
  var temp;
  var weather;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Nigeria&units=metric&appid=527652ebc22387cc038e51aa6977e5d3"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.weather = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  // initialize the state of getWeather
  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    kDefaultPadding, kDefaultPadding, kDefaultPadding, 0),
                height: size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFD5D6D7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 1.0,
                      blurRadius: 15,
                      offset: Offset(4.0, 4.0),
                    ),
                    BoxShadow(
                      color: Colors.white60,
                      spreadRadius: 1.0,
                      blurRadius: 5,
                      offset: Offset(-4.0, -4.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'This is the Weather Forecast right from Nigeria',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(kDefaultPadding),
                height: size.height * 50,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFD5D6D7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1.0,
                              blurRadius: 15,
                              offset: Offset(4.0, 4.0),
                            ),
                            BoxShadow(
                              color: Colors.white60,
                              spreadRadius: 1.0,
                              blurRadius: 5,
                              offset: Offset(-4.0, -4.0),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(FontAwesomeIcons.thermometer),
                            Text(
                              'Temperature',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black45,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              temp != null // temp != null && temp > 25
                                  ? temp.toString() + "\u00B0"
                                  : 'Loading',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black45,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              height: size.height * 0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFD5D6D7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    spreadRadius: 1.0,
                                    blurRadius: 15,
                                    offset: Offset(4.0, 4.0),
                                  ),
                                  BoxShadow(
                                    color: Colors.white60,
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: Offset(-4.0, -4.0),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(FontAwesomeIcons.cloud),
                                  Text(
                                    'Weather',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black45,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    weather != null
                                        ? weather.toString()
                                        : 'Loading',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black45,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Color(0xFFD5D6D7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    spreadRadius: 1.0,
                                    blurRadius: 15,
                                    offset: Offset(4.0, 4.0),
                                  ),
                                  BoxShadow(
                                    color: Colors.white60,
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: Offset(-4.0, -4.0),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(FontAwesomeIcons.sun),
                                  Text(
                                    'Humidity',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black45,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    humidity != null
                                        ? humidity.toString() + "\u00B0"
                                        : 'Loading',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black45,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFD5D6D7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              spreadRadius: 5.0,
                              blurRadius: 10,
                              offset: Offset.fromDirection(-5),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 5.0,
                              blurRadius: 10,
                              offset: Offset.fromDirection(5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(FontAwesomeIcons.wind),
                            Text(
                              'WindSpeed',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black45,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              windSpeed != null
                                  ? windSpeed.toString() + "\u00B0"
                                  : 'Loading',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black45,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                decoration: BoxDecoration(
                  color: Color(0xFFD5D6D7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 1.0,
                      blurRadius: 15,
                      offset: Offset(4.0, 4.0),
                    ),
                    BoxShadow(
                      color: Colors.white60,
                      spreadRadius: 1.0,
                      blurRadius: 5,
                      offset: Offset(-4.0, -4.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.tools),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Tips',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black45,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      getRandomElement(tipList),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black45,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
