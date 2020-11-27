import 'package:meteo_weather/models/city.dart';

abstract class CityProvider {
  Future<List<City>> getAllCities();
  Future<List<City>> getFilteredCities(String query);
}