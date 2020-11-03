import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/city_provider.dart';

class Repository implements CityProvider{
  final CityProvider localCityProvider;

  Repository(this.localCityProvider);

  @override
  Future<List<City>> getAllCities() async {
    return localCityProvider.getAllCities();
  }

  @override
  Future<List<City>> getFavouritesCities() {
    return localCityProvider.getFavouritesCities();
  }

  @override
  Future<void> removeCityFromFavourites(City city) {
    return localCityProvider.removeCityFromFavourites(city);
  }

}