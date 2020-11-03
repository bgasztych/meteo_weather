import 'package:equatable/equatable.dart';
import 'package:meteo_weather/models/city.dart';

abstract class FavouritesCitiesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouritesCitiesFetched extends FavouritesCitiesEvent {}

class FavouritesCitiesAdded extends FavouritesCitiesEvent {
  final City city;

  FavouritesCitiesAdded(this.city);

  @override
  List<Object> get props => [city];

  @override
  String toString() {
    return 'FavouritesCitiesAdded{city: $city}';
  }
}

class FavouritesCitiesRemoved extends FavouritesCitiesEvent {
  final City city;

  FavouritesCitiesRemoved(this.city);

  @override
  List<Object> get props => [city];

  @override
  String toString() {
    return 'FavouritesCitiesRemoved{city: $city}';
  }
}