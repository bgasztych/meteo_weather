part of 'filtered_cities_bloc.dart';

abstract class FilteredCitiesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FilteredCitiesFiltered extends FilteredCitiesEvent {
  final String query;

  FilteredCitiesFiltered(this.query);

  @override
  List<Object> get props => [query];

  @override
  String toString() {
    return 'FilteredCitiesFiltered{query: $query}';
  }
}