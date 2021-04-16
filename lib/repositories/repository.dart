import 'package:meteo_weather/models/city.dart';

import '../logger.dart';
import 'providers/city_provider.dart';
import 'providers/favourite_city_provider.dart';

class Repository implements FavouriteCityProvider{
  final FavouriteCityProvider _localCityProvider;
  final CityProvider _remoteCityProvider;

  Repository(this._localCityProvider, this._remoteCityProvider);

  @override
  Future<List<City>> getAllCities() async {
    try {
      List<City> cities = await _localCityProvider.getAllCities();
      if (cities.isEmpty) {
        cities = await _remoteCityProvider.getAllCities();
        await _localCityProvider.addCities(cities);
        return cities;
      }
    } on Exception catch (e) {
      Logger().e(e);
    }
    return _localCityProvider.getAllCities();
  }

  @override
  Future<List<City>> getFavouritesCities() async {
    final refreshInterval = Duration(hours: 3);
    try {
      List<City> cities = await _localCityProvider.getFavouritesCities();
      final refreshDate = await _localCityProvider.getRefreshFavouritesCitiesDate();
      if (DateTime.now().difference(refreshDate) > refreshInterval) {
        cities = await _remoteCityProvider.getFavouritesCities();
        await _localCityProvider.updateFavouritesCities(cities);
        return cities;
      }
    } on Exception catch (e) {
      Logger().e(e);
    }
    return _localCityProvider.getFavouritesCities();
  }

  @override
  Future<List<City>> getFilteredCities(String query) async {
    return _localCityProvider.getFilteredCities(query);
  }

  @override
  Future<void> removeCityFromFavourites(City city) async {
    _localCityProvider.removeCityFromFavourites(city);
  }

  @override
  Future<void> addCityToFavourites(City city) async {
    _localCityProvider.addCityToFavourites(city);
  }

  @override
  Future<City> getCity(int id) async {
    return _localCityProvider.getCity(id);
  }

  @override
  Future<DateTime> getRefreshCitiesDate() async {
   return _localCityProvider.getRefreshCitiesDate();
  }

  @override
  Future<void> addCities(List<City> cities) async {
    _localCityProvider.addCities(cities);
  }

  @override
  Future<DateTime> getRefreshFavouritesCitiesDate() {
    return _localCityProvider.getRefreshFavouritesCitiesDate();
  }

}