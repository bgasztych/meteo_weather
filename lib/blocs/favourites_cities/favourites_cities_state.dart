import 'package:equatable/equatable.dart';
import 'package:meteo_weather/models/city.dart';

abstract class FavouritesCitiesState extends Equatable {
  const FavouritesCitiesState();

  @override
  List<Object> get props => [];
}

class FavouritesCitiesLoading extends FavouritesCitiesState {}

class FavouritesCitiesFailure extends FavouritesCitiesState {}

class FavouritesCitiesSuccess extends FavouritesCitiesState {
  final List<City> cities;

  const FavouritesCitiesSuccess({this.cities});

  FavouritesCitiesSuccess copyWith({List<City> cities}) {
    return FavouritesCitiesSuccess(cities: cities ?? this.cities);
  }

  @override
  List<Object> get props => [cities];

  @override
  String toString() {
    return 'FavouritesCitiesSuccess{cities: ${cities.length}';
  }
}