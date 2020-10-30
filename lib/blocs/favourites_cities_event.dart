import 'package:equatable/equatable.dart';

abstract class FavouritesCitiesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FavouritesCitiesFetched extends FavouritesCitiesEvent {}
