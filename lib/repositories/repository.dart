import 'package:meteo_weather/models/city.dart';

import '../logger.dart';
import 'providers/city_provider.dart';
import 'providers/favourite_city_provider.dart';

class Repository {
  final FavouriteCityProvider _localCityProvider;
  final CityProvider _remoteCityProvider;

  static const Duration REFRESH_INTERVAL = const Duration(hours: 3);

  Repository(this._localCityProvider, this._remoteCityProvider);

  Future<List<City>> getFavouritesCities({bool forceRefresh}) async {
    // TODO If (now - updated_date) > refresh interval -> getFavouritesCities from remote and update
    if (forceRefresh ||
        (DateTime.now()
                .difference((await _localCityProvider.getLastUpdatedDate()))
                .compareTo(REFRESH_INTERVAL) >
            0)) {
      List<City> cities = await _localCityProvider.getFavouritesCities();
      List<int> citiesIds = cities.map((city) => city.id);
      List<City> updatedCities =
          await _remoteCityProvider.getCitiesByIds(citiesIds);
      await _localCityProvider.updateFavouriteCities(updatedCities);
      return updatedCities;
    } else {
      return _localCityProvider.getFavouritesCities();
    }
  }

  Future<List<City>> getFilteredCities(String query) async {
    return _remoteCityProvider.getFilteredCities(query);
  }

  Future<void> removeCityFromFavourites(City city) async {
    _localCityProvider.removeCityFromFavourites(city);
  }

  Future<void> addCityToFavourites(City city) async {
    _localCityProvider.addCityToFavourites(city);
  }

  Future<void> updateFavouriteCity(City city) async {
    _localCityProvider.updateFavouriteCity(city);
  }
}
