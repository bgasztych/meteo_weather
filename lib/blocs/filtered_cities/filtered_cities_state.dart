part of 'filtered_cities_bloc.dart';

abstract class FilteredCitiesState extends Equatable {
  const FilteredCitiesState();

  @override
  List<Object> get props => [];
}

class FilteredCitiesLoading extends FilteredCitiesState {}

class FilteredCitiesFailure extends FilteredCitiesState {}

class FilteredCitiesSuccess extends FilteredCitiesState {
  final List<City> cities;

  const FilteredCitiesSuccess(this.cities);

  @override
  List<Object> get props => [cities];

  @override
  String toString() {
    return 'FilteredCitiesSuccess{cities: ${cities.length}';
  }
}
