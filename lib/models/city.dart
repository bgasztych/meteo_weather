import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class City extends Equatable {
  final int id;
  final String city;
  final String voivodeship;
  final String imageUri;

  City(this.id, this.city, this.voivodeship, this.imageUri);

  @override
  List<Object> get props => [id, city, voivodeship, imageUri];

  @override
  String toString() {
    return 'City{id: $id, city: $city, voivodeship: $voivodeship, imageUri: $imageUri}';
  }
}