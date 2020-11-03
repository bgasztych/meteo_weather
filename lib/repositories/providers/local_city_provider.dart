import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/city_provider.dart';

class LocalCityProvider implements CityProvider {
  final List<City> _favouritedCities = [
    City(0, "Wrocław", "dolnoślaskie", null),
    City(6, "Wronki", "dolnoślaskie", null),
  ];

  @override
  Future<List<City>> getAllCities() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      City(0, "Wrocław", "dolnoślaskie", null),
      City(1, "Opole", "dolnoślaskie", null),
      City(2, "Warszawa", "mazowieckie", null),
      City(3, "Poznań", "wielkopolskie", null),
      City(4, "Gdańsk", "pomorskie", null),
      City(5, "Jelenia Góra", "dolnoślaskie", null),
      City(6, "Wronki", "dolnoślaskie", null),
    ];
  }

  @override
  Future<List<City>> getFavouritesCities() async {
    await Future.delayed(Duration(seconds: 2));
    return List.unmodifiable(_favouritedCities);
  }

  @override
  Future<void> removeCityFromFavourites(City city) async {
    _favouritedCities.remove(city);
  }

}