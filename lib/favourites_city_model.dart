import 'package:flutter/material.dart';
import 'package:meteo_weather/logger.dart';

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

@immutable
class City {
  final int id;
  final String city;
  final String voivodeship;
  final String imageUri;

  City(this.id, this.city, this.voivodeship, this.imageUri);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is City && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'City{id: $id, city: $city, voivodeship: $voivodeship, imageUri: $imageUri}';
  }

  Map toJson() => {
    'id': id,
    'city': city,
    'voivodeship': voivodeship,
    'imageUri': imageUri
  };
}