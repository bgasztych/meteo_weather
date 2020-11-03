import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meteo_weather/blocs/bloc.dart';
import 'package:meteo_weather/logger.dart';
import 'package:meteo_weather/repositories/repository.dart';

class FavouritesCitiesBloc
    extends Bloc<FavouritesCitiesEvent, FavouritesCitiesState> {
  final Repository repository;

  FavouritesCitiesBloc(this.repository) : super(FavouritesCitiesLoading());

  @override
  Stream<FavouritesCitiesState> mapEventToState(
    FavouritesCitiesEvent event,
  ) async* {
    if (event is FavouritesCitiesFetched) {
      try {
        final cities = await repository.getFavouritesCities();
        yield FavouritesCitiesSuccess(cities: cities);
        return;
      } catch (_) {
        yield FavouritesCitiesFailure();
      }
    } else if (event is FavouritesCitiesRemovedCity) {
      if (state is FavouritesCitiesSuccess) {
        final updatedCities = (state as FavouritesCitiesSuccess)
            .cities
            .where((city) => city != event.city)
            .toList();
        await repository.removeCityFromFavourites(event.city);
        yield FavouritesCitiesSuccess(cities: updatedCities);
      }
    }
  }

  // TODO For debug purpose
  @override
  void onTransition(
      Transition<FavouritesCitiesEvent, FavouritesCitiesState> transition) {
    Logger.d(transition);
    super.onTransition(transition);
  }
}
