import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/city_provider.dart';

abstract class FavouriteCityProvider extends CityProvider {
  Future<List<City>> getFavouritesCities();
  Future<void> removeCityFromFavourites(City city);
  Future<void> addCityToFavourites(City city);
  Future<DateTime> getRefreshCitiesDate();
  Future<void> addCities(List<City> cities);
}