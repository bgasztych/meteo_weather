import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/city_provider.dart';

abstract class FavouriteCityProvider {
  Future<City> getFavouriteCity(int id);
  Future<List<City>> getFavouritesCities();
  Future<void> removeCityFromFavourites(City city);
  Future<void> addCityToFavourites(City city);
  Future<void> updateFavouriteCity(City city);
  Future<void> updateFavouriteCities(List<City> cities);
  Future<DateTime> getLastUpdatedDate();
}