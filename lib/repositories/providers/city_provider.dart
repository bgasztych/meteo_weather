import 'package:meteo_weather/models/city.dart';

abstract class CityProvider {
  Future<List<City>> getFilteredCities(String query);
  Future<List<City>> getCitiesByIds(List<int> ids);
  Future<City> getCity(int id);
}