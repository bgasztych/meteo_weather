import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/repository.dart';

import 'favourites_cities_event.dart';
import 'favourites_cities_state.dart';

class FavouritesCitiesBloc
    extends Bloc<FavouritesCitiesEvent, FavouritesCitiesState> {
  final Repository repository;

  FavouritesCitiesBloc(this.repository) : super(FavouritesCitiesLoading());

  @override
  Stream<FavouritesCitiesState> mapEventToState(
    FavouritesCitiesEvent event,
  ) async* {
    if (event is FavouritesCitiesFetched) {
      yield* _mapFavouritesCitiesFetchedToState();
    } else if (event is FavouritesCitiesAdded) {
      yield* _mapFavouritesCitiesAddedToState(event);
    } else if (event is FavouritesCitiesRemoved) {
      yield* _mapFavouritesCitiesRemovedToState(event);
    }
  }

  Stream<FavouritesCitiesState> _mapFavouritesCitiesFetchedToState() async* {
    try {
      final cities = await repository.getFavouritesCities();
      yield FavouritesCitiesSuccess(cities: cities);
    } catch (_) {
      yield FavouritesCitiesFailure();
    }
  }

  Stream<FavouritesCitiesState> _mapFavouritesCitiesAddedToState(
      FavouritesCitiesAdded event) async* {
    if (state is FavouritesCitiesSuccess) {
      final List<City> updatedCities = List.from((state as FavouritesCitiesSuccess).cities);
      if (!updatedCities.contains(event.city)) {
        updatedCities.add(event.city);
        repository.addCityToFavourites(event.city);
      }
      yield FavouritesCitiesSuccess(cities: updatedCities);
    }
  }

  Stream<FavouritesCitiesState> _mapFavouritesCitiesRemovedToState(
      FavouritesCitiesRemoved event) async* {
    if (state is FavouritesCitiesSuccess) {
      final List<City> updatedCities = (state as FavouritesCitiesSuccess)
          .cities
          .where((city) => city != event.city).toList();
      yield FavouritesCitiesSuccess(cities: updatedCities);
      repository.removeCityFromFavourites(event.city);
    }
  }
}
