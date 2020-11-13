import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class City extends Equatable {
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
      'id': id,
      'city': city,
      'voivodeship': voivodeship,
      'meteogramBase64': meteogramBase64,
      'updatedDate': updatedDate.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return 'City{id: $id, city: $city, voivodeship: $voivodeship, imageUri: $meteogramBase64, updatedDate: $updatedDate}';
  }
}