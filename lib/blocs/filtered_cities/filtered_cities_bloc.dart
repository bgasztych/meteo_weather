import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/repository.dart';

part 'filtered_cities_event.dart';
part 'filtered_cities_state.dart';

class FilteredCitiesBloc extends Bloc<FilteredCitiesEvent, FilteredCitiesState> {
  final Repository repository;

  FilteredCitiesBloc(this.repository) : super(FilteredCitiesLoading());

  @override
  Stream<FilteredCitiesState> mapEventToState(
    FilteredCitiesEvent event,
  ) async* {
    if (event is FilteredCitiesFiltered) {
      yield* _mapFilteredCitiesFilteredToState(event);
    }
  }

  Stream<FilteredCitiesState> _mapFilteredCitiesFilteredToState(FilteredCitiesFiltered event) async* {
    if (state is FilteredCitiesSuccess) {
      yield FilteredCitiesLoading();
    }
    try {
      final filteredCities = await repository.getFilteredCities(event.query);
      yield FilteredCitiesSuccess(filteredCities);
    } catch (_) {
      yield FilteredCitiesFailure();
    }
  }
}
