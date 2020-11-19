import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/city_provider.dart';

import '../../logger.dart';

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
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
  }

  void _initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        Logger().i(
            "${options.method} ${options.baseUrl}${options
                .path}\nHeaders: ${JsonEncoder.withIndent('  ').convert(
                options.headers)}\nContent type: ${options
                .contentType}\n\nBody:\n${JsonEncoder.withIndent('  ').convert(
                options?.data)}");
        return options;
      },
      onResponse: (Response response) {
        Logger().i(
            "${response?.statusCode} ${response?.statusMessage} from ${response
                .request.baseUrl}${response.request.path}\nHeaders:\n${response
                .headers}\nResponse:\n${JsonEncoder.withIndent('  ').convert(
                response?.data)}");
        return response;
      },
      onError: (DioError e) {
        Logger().e(
            "${e.response?.statusCode} ${e.response?.statusMessage} from ${e
                .request.baseUrl}${e.request.path}\nHeaders:\n${e.response
                ?.headers}\nResponse:\n${JsonEncoder.withIndent('  ').convert(
                e.response?.data)}",
            e);
        return e;
      },
    ));
  }

  @override
  Future<void> addCityToFavourites(City city) {
    // TODO: implement addCityToFavourites
    throw UnimplementedError();
  }

  @override
  Future<List<City>> getAllCities() {
    // TODO: implement getAllCities
    throw UnimplementedError();
  }

  @override
  Future<List<City>> getFavouritesCities() {
    // TODO: implement getFavouritesCities
    throw UnimplementedError();
  }

  @override
  Future<List<City>> getFilteredCities(String query) {
    // TODO: implement getFilteredCities
    throw UnimplementedError();
  }

  @override
  Future<void> removeCityFromFavourites(City city) {
    // TODO: implement removeCityFromFavourites
    throw UnimplementedError();
  }

}