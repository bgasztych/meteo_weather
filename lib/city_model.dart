import 'package:flutter/material.dart';

class CityModel {
  static List<City> cities = [
    City(0, "Wrocław", "dolnoślaskie", null),
    City(1, "Opole", "dolnoślaskie", null),
    City(2, "Warszawa", "mazowieckie", null),
    City(3, "Poznań", "wielkopolskie", null),
    City(4, "Gdańsk", "pomorskie", null),
    City(5, "Jelenia Góra", "dolnoślaskie", null),
  ];
}

@immutable
class City {
  final int id;
  final String city;
  final String voivodeship;
  final String imageUri;

  City(this.id, this.city, this.voivodeship, this.imageUri);
}