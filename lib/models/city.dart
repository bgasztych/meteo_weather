import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meteo_weather/repositories/providers/local_city_provider.dart';

class City extends Equatable {
  static const String CITIES_ID = "id";
  static const String CITIES_CITY = "city";
  static const String CITIES_VOIVODESHIP = "voivodeship";
  static const String CITIES_METEOGRAM = "meteogram";
  static const String CITIES_UPDATED_DATE = "updated_date";
  static const String CITIES_IS_FAVOURITE = "is_favourite";

  final int id;
  final String city;
  final String voivodeship;
  String meteogramBase64;
  DateTime updatedDate;

  City(this.id, this.city, this.voivodeship, this.meteogramBase64, this.updatedDate);

  @override
  List<Object> get props => [id, city, voivodeship];

  Map<String, dynamic> toMap() {
    return {
      CITIES_ID: id,
      CITIES_CITY: city,
      CITIES_VOIVODESHIP: voivodeship,
      CITIES_METEOGRAM: meteogramBase64,
      CITIES_UPDATED_DATE: updatedDate.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return 'City{id: $id, city: $city, voivodeship: $voivodeship, meteogramBase64: $meteogramBase64, updatedDate: $updatedDate}';
  }
}