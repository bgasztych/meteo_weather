import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meteo_weather/repositories/providers/local_city_provider.dart';

class City extends Equatable {
  final int id;
  final String city;
  final String voivodeship;
  String meteogramBase64;
  DateTime updatedDate;

  City(this.id, this.city, this.voivodeship, this.meteogramBase64, this.updatedDate);

  @override
  List<Object> get props => [id, city, voivodeship];

  // TODO Remove dependency from LocalCityProvider
  Map<String, dynamic> toMap() {
    return {
      LocalCityProvider.CITIES_ID: id,
      LocalCityProvider.CITIES_CITY: city,
      LocalCityProvider.CITIES_VOIVODESHIP: voivodeship,
      LocalCityProvider.CITIES_METEOGRAM: meteogramBase64,
      LocalCityProvider.CITIES_UPDATED_DATE: updatedDate.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return 'City{id: $id, city: $city, voivodeship: $voivodeship, imageUri: $meteogramBase64, updatedDate: $updatedDate}';
  }
}