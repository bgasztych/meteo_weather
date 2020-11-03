import 'package:meteo_weather/models/city.dart';

abstract class CityProvider {
  Future<List<City>> getAllCities();
  Future<List<City>> getFavouritesCities();
  Future<List<City>> getFilteredCities(String query);
  Future<void> removeCityFromFavourites(City city);
  Future<void> addCityToFavourites(City city);
}