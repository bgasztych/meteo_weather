import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/city_provider.dart';

class Repository implements CityProvider{
  final CityProvider _localCityProvider;

  Repository(this._localCityProvider);

  @override
  Future<List<City>> getAllCities() async {
    return _localCityProvider.getAllCities();
  }

  @override
  Future<List<City>> getFavouritesCities() async {
    return _localCityProvider.getFavouritesCities();
  }

  @override
  Future<List<City>> getFilteredCities(String query) async {
    return _localCityProvider.getFilteredCities(query);
  }

  @override
  Future<void> removeCityFromFavourites(City city) async {
    return _localCityProvider.removeCityFromFavourites(city);
  }

  @override
  Future<void> addCityToFavourites(City city) async {
    return _localCityProvider.addCityToFavourites(city);
  }

}