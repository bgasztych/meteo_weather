import 'package:meteo_weather/models/city.dart';

import '../logger.dart';
import 'providers/city_provider.dart';
import 'providers/favourite_city_provider.dart';

class Repository implements CityProvider, FavouriteCityProvider{
  final FavouriteCityProvider _localCityProvider;
  final CityProvider _remoteCityProvider;

  Repository(this._localCityProvider, this._remoteCityProvider);

  @override
  Future<List<City>> getAllCities() async {
    return _remoteCityProvider.getAllCities();
  }

  @override
  Future<List<City>> getFavouritesCities({bool forceRefresh}) async {
    // TODO If (now - updated_date) > refresh interval -> getFavouritesCities from remote and update
    return _localCityProvider.getFavouritesCities();
  }

  @override
  Future<List<City>> getFilteredCities(String query) async {
    return _remoteCityProvider.getFilteredCities(query);
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
    return _remoteCityProvider.getCity(id);
  }

  @override
  Future<City> getFavouriteCity(int id) {
    return _localCityProvider.getFavouriteCity(id);
  }

  @override
  Future<DateTime> getRefreshFavouritesCitiesDate() {
    return _localCityProvider.getRefreshFavouritesCitiesDate();
  }

  @override
  Future<void> updateFavouriteCity(City city) {
    return _localCityProvider.updateFavouriteCity(city);
  }

}