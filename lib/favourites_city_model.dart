import 'package:flutter/material.dart';
import 'package:meteo_weather/logger.dart';
import 'package:meteo_weather/models/city.dart';

class FavouriteCityModel extends ChangeNotifier {
  static List<City> cities = [
    City(0, "Wrocław", "dolnoślaskie", null),
    City(1, "Opole", "dolnoślaskie", null),
    City(2, "Warszawa", "mazowieckie", null),
    City(3, "Poznań", "wielkopolskie", null),
    City(4, "Gdańsk", "pomorskie", null),
    City(5, "Jelenia Góra", "dolnoślaskie", null),
    City(6, "Wronki", "dolnoślaskie", null),
  ];

  List<City> _favouritesCities = [];

  void add(City city) {
    if (!_favouritesCities.contains(city)) {
      _favouritesCities.add(city);
      notifyListeners();
    }
  }

  void remove(City city) {
    _favouritesCities.remove(city);
    notifyListeners();
  }

  City get(int position) => _favouritesCities[position];

  bool contains(City city) => _favouritesCities.contains(city);

  int length() => _favouritesCities.length;

  List<City> searchCities(String query) {
    List<City> matchCities = [];
    cities.forEach((element) {
      if (element.city.toLowerCase().startsWith(query.toLowerCase())) {
        Logger.d(element);
        matchCities.add(element);
      }
    });
    return matchCities;
  }
}