import 'package:flutter/material.dart';
import 'package:meteo_weather/favourites_city_model.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class MeteoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meteo App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => FavouriteCityModel(),
        child: HomeScreen(),
      ),
    );
  }
}
