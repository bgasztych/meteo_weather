import 'package:flutter/material.dart';

class FavouriteCityModel extends ChangeNotifier {
  static List<City> cities = [
    City(0, "Wrocław", "dolnoślaskie", null),
    City(1, "Opole", "dolnoślaskie", null),
    City(2, "Warszawa", "mazowieckie", null),
    City(3, "Poznań", "wielkopolskie", null),
    City(4, "Gdańsk", "pomorskie", null),
    City(5, "Jelenia Góra", "dolnoślaskie", null),
  ];

  List<City> _favouritesCities = [];

  void add(City city) {
    _favouritesCities.add(city);
    notifyListeners();
  }

  void remove(City city) {
    _favouritesCities.remove(city);
  }

  City get(int position) => _favouritesCities[position];

  int length() => _favouritesCities.length;

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
}