import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/city_provider.dart';

class LocalCityProvider implements CityProvider {
  final List<City> _favouritedCities = [
    City(0, "Wrocław", "dolnoślaskie", null),
    City(1, "Opole", "dolnoślaskie", null),
    City(2, "Warszawa", "mazowieckie", null),
    City(3, "Poznań", "wielkopolskie", null),
    City(4, "Gdańsk", "pomorskie", null),
    City(5, "Jelenia Góra", "dolnoślaskie", null),
    City(6, "Wronki", "dolnoślaskie", null),
    City(7, "Białystok", "podlaskie", null),
    City(8, "Zielona Góra", "lubuskie", null),
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
      City(7, "Białystok", "podlaskie", null),
      City(8, "Zielona Góra", "lubuskie", null),
      City(9, "Bydgoszcz", "kujawsko-pomorskie", null),
      City(10, "Gorzów Wielkopolski", "lubuskie", null),
      City(11, "Katowice", "śląskie", null),
      City(12, "Kielce", "świętokrzyskie", null),
      City(13, "Kraków", "małopolskie", null),
      City(14, "Lublin", "lubelskie", null),
      City(15, "Łódź", "łódzkie", null),
      City(16, "Olsztyn", "warmińsko-mazurskie", null),
      City(17, "Rzeszów", "podkarpackie", null),
      City(18, "Szczecin", "zachodniopomorskie", null),
      City(19, "Toruń", "kujawsko-pomorskie", null),
    ];
  }

  @override
  Future<List<City>> getFavouritesCities() async {
    await Future.delayed(Duration(seconds: 2));
    return List.unmodifiable(_favouritedCities);
  }

  @override
  Future<List<City>> getFilteredCities(String query) async {
    return List.unmodifiable((await getAllCities()).where(
        (city) => city.city.toLowerCase().startsWith(query.toLowerCase())));
  }

  @override
  Future<void> removeCityFromFavourites(City city) async {
    _favouritedCities.remove(city);
  }

  @override
  Future<void> addCityToFavourites(City city) async {
    _favouritedCities.add(city);
  }
}
