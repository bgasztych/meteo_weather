import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meteo_weather/blocs/bloc.dart';
import 'package:meteo_weather/logger.dart';
import 'package:meteo_weather/repositories/repository.dart';

class FavouritesCitiesBloc
    extends Bloc<FavouritesCitiesEvent, FavouritesCitiesState> {
  final Repository repository;

  FavouritesCitiesBloc(this.repository) : super(FavouritesCitiesInitial());

  @override
  Stream<FavouritesCitiesState> mapEventToState(
    FavouritesCitiesEvent event,
  ) async* {
    final currentState = state;
    if (event is FavouritesCitiesFetched) {
      try {
        if (currentState is FavouritesCitiesInitial) {
          final cities = await repository.getFavouritesCities();
          yield FavouritesCitiesSuccess(cities: cities);
          return;
        }
        if (currentState is FavouritesCitiesSuccess) {
          // TODO
          Logger.d("Success: $currentState");
        }
      } catch (_) {
        yield FavouritesCitiesFailure();
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
