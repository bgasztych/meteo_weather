import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/favourite_city_provider.dart';

import '../../logger.dart';
import 'city_provider.dart';

class RemoteCityProvider implements CityProvider {
  RemoteCityProvider._(this.baseUrl) {
    _initDio();
    _initInterceptors();
  }

  factory RemoteCityProvider(String baseUrl) {
    return RemoteCityProvider._(baseUrl);
  }

  final String baseUrl;
  Dio _dio;

  void _initDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.plain,
    );
    _dio = Dio(options);
  }

  void _initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        Logger().i(
            "${options.method} ${options.uri}\nHeaders: ${JsonEncoder.withIndent('  ').convert(options.headers)}\nContent type: ${options.contentType}\n\nBody:\n${JsonEncoder.withIndent('  ').convert(options?.data)}");
        return options;
      },
      onResponse: (Response response) {
        Logger().i(
            "${response?.statusCode} ${response?.statusMessage} from ${response.request.uri}\nHeaders:\n${response.headers}\nResponse:\n${JsonEncoder.withIndent('  ').convert(response?.data)}");
        return response;
      },
      onError: (DioError e) {
        Logger().e(
            "${e.response?.statusCode} ${e.response?.statusMessage} from ${e.request.uri}\nHeaders:\n${e.response?.headers}\nResponse:\n${JsonEncoder.withIndent('  ').convert(e.response?.data)}",
            e);
        return e;
      },
    ));
  }

  final List<City> _allCities = [
    City(0, "Wrocław", "dolnoślaskie", null, DateTime.now()),
    City(1, "Opole", "dolnoślaskie", null, DateTime.now()),
    City(2, "Warszawa", "mazowieckie", null, DateTime.now()),
    City(3, "Poznań", "wielkopolskie", null, DateTime.now()),
    City(4, "Gdańsk", "pomorskie", null, DateTime.now()),
    City(5, "Jelenia Góra", "dolnoślaskie", null, DateTime.now()),
    City(6, "Wronki", "dolnoślaskie", null, DateTime.now()),
    City(7, "Białystok", "podlaskie", null, DateTime.now()),
    City(8, "Zielona Góra", "lubuskie", null, DateTime.now()),
    City(9, "Bydgoszcz", "kujawsko-pomorskie", null, DateTime.now()),
    City(10, "Gorzów Wielkopolski", "lubuskie", null, DateTime.now()),
    City(11, "Katowice", "śląskie", null, DateTime.now()),
    City(12, "Kielce", "świętokrzyskie", null, DateTime.now()),
    City(13, "Kraków", "małopolskie", null, DateTime.now()),
    City(14, "Lublin", "lubelskie", null, DateTime.now()),
    City(15, "Łódź", "łódzkie", null, DateTime.now()),
    City(16, "Olsztyn", "warmińsko-mazurskie", null, DateTime.now()),
    City(17, "Rzeszów", "podkarpackie", null, DateTime.now()),
    City(18, "Szczecin", "zachodniopomorskie", null, DateTime.now()),
    City(19, "Toruń", "kujawsko-pomorskie", null, DateTime.now()),
  ];

  @override
  Future<List<City>> getFilteredCities(String query) async {
    // TODO: implement getFilteredCities
    return Future.delayed(
        Duration(seconds: 1),
        () => _allCities
            .where((city) =>
                city.city.toLowerCase().startsWith(query.toLowerCase()))
            .toList());
  }

  @override
  Future<City> getCity(int id) async {
    Response response = await _dio.get('/php/meteorogram_id_um.php', queryParameters: {'ntype': '0u', 'id': id.toString()});
    Document document = Document.html(response.data);
    String script = document.getElementsByTagName('script')[6].firstChild.toString();

    RegExp expX = RegExp(r"var act_x = \d{2,3};");
    RegExp expY = RegExp(r"var act_y = \d{2,3};");

    int x = _parseCoordinate(expX, script);
    int y = _parseCoordinate(expY, script);
    
    String city = document.getElementById('model_napis').text.replaceFirst('UM\n\n', '');
    // for (String c in city.split(',')) {
    //   Logger().d(c);
    // }
    List<String> citySplitted = city.split(',');

    String cityName = citySplitted[0];
    String voivodeship = '';

    if (citySplitted.length == 3) {
      voivodeship = '${citySplitted[1].trimLeft()}, ${citySplitted[2].trimLeft()}';
    } else if (citySplitted.length == 2) {
      voivodeship = citySplitted[1].trimLeft();
    }

    Logger().d('x = $x y = $y cityName = $cityName voivodeship = $voivodeship');

    // TODO: implement getCity
    return Future.delayed(Duration(milliseconds: 300), () => _allCities[id]);
  }

  int _parseCoordinate(RegExp exp, String script) {
    RegExp numberExp = RegExp(r"\d{2,3}");
    String coordinate = numberExp.firstMatch(exp.firstMatch(script)[0])[0];
    return int.parse(coordinate);
  }

  @override
  Future<List<City>> getCitiesByIds(List<int> ids) {
    // TODO: implement getCitiesByIds
    throw UnimplementedError();
  }
}
