import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meteo_weather/models/city.dart';

part 'filtered_cities_event.dart';
part 'filtered_cities_state.dart';

class FilteredCitiesBloc extends Bloc<FilteredCitiesEvent, FilteredCitiesState> {
  FilteredCitiesBloc() : super(FilteredCitiesLoading());

  @override
  Stream<FilteredCitiesState> mapEventToState(
    FilteredCitiesEvent event,
  ) async* {
    if (event is FilteredCitiesFiltered) {
      yield* _mapFilteredCitiesFilteredToState(event);
    }
  }

  Stream<FilteredCitiesState> _mapFilteredCitiesFilteredToState(FilteredCitiesFiltered event) async* {
    // TODO
  }
}
