import 'package:meteo_weather/models/city.dart';

import 'providers/city_provider.dart';
import 'providers/favourite_city_provider.dart';

class Repository implements FavouriteCityProvider{
  final FavouriteCityProvider _localCityProvider;
  final CityProvider _remoteCityProvider;

  Repository(this._localCityProvider, this._remoteCityProvider);

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