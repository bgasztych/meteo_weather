import 'package:flutter/material.dart';
import 'package:meteo_weather/favourites_city_model.dart';

class MeteogramScreen extends StatelessWidget {
  final City city;

  MeteogramScreen({Key key, @required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(city.city)),
      body: Center(child: Text("placeholder")),
    );
  }
}
