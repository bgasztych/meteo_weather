import 'package:equatable/equatable.dart';
import 'package:meteo_weather/models/city.dart';

abstract class FavouritesCitiesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouritesCitiesFetched extends FavouritesCitiesEvent {}

class FavouritesCitiesRemovedCity extends FavouritesCitiesEvent {
  final City city;

  FavouritesCitiesRemovedCity(this.city);

  @override
  List<Object> get props => [city];
}