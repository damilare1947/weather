import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: 'Weather app',
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=Ikeja&units=imperial&appid=882a1fe81f4b53071dfca18db3f89f00');

    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        body: Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.orange[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text('Currently in Ikeja',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600))),
                Text(temp != null ? temp.toString() + "\u00B0" : 'Loading',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null
                        ? currently.toString() + "\u00B0"
                        : 'Loading',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )),
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      newMethod('Temperature', FontAwesomeIcons.thermometerHalf,
                          temp),
                      //SizedBox(width: 20.0),
                      newMethod('Weather', FontAwesomeIcons.cloud, description),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      newMethod('Humidity', FontAwesomeIcons.sun, humidity),
                      //SizedBox(width: 20.0),
                      newMethod('Wind Speed', FontAwesomeIcons.wind, windSpeed),
                    ],
                  ),
                ],
              )),
        )
      ],
    ));
  }

  Card newMethod(String text2, IconData icon, dynamic apiData) {
    return Card(
      color: Colors.orange[200],
      child: Container(
          //color: Colors.red,
          width: 150.0,
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon),
              Text(apiData != null ? apiData.toString() + "\u00B0" : 'Loading',
                  style: TextStyle(fontSize: 20.0)),
              Text(text2)
            ],
          )),
    );
  }
}
