import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_weather/blocs/bloc.dart';
import 'package:meteo_weather/favourites_city_model.dart';
import 'package:meteo_weather/logger.dart';
import 'package:meteo_weather/meteogram_screen.dart';
import 'package:meteo_weather/models/city.dart';
import 'package:provider/provider.dart';

class FavouritesCitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavouritesCitiesBloc _favouriteCitiesBloc =
        BlocProvider.of<FavouritesCitiesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () => showSearch(
          //     context: context,
          //     delegate: CitySearchDelegate(favouriteCityModel),
          //   ),
          // ),
        ],
      ),
      body: BlocBuilder<FavouritesCitiesBloc, FavouritesCitiesState>(
          // ignore: missing_return
          builder: (context, state) {
        if (state is FavouritesCitiesInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is FavouritesCitiesSuccess) {
          if (state.cities.isEmpty) {
            return Center(child: Text("No favourites cities"));
          }
          return ListView.builder(
            itemCount: state.cities.length,
            itemBuilder: (BuildContext context, int index) =>
                FavouriteCityWidget(city: state.cities[index]),
          );
        }
        if (state is FavouritesCitiesFailure) {
          return Center(child: Text("Failed to fetch favourites cities"));
        }
      }),
    );
  }

  void _onCityPressed(BuildContext context, City city) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MeteogramScreen(city: city)));
  }

  void _onRemoveCityPressed(
      BuildContext context, FavouriteCityModel model, City city) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("Remove from favourites?"),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      model.remove(city);
                      Navigator.pop(context);
                    },
                    child: Text("Remove"))
              ],
            ));
  }
}

class FavouriteCityWidget extends StatelessWidget {
  final City city;

  const FavouriteCityWidget({Key key, @required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavouritesCitiesBloc _bloc =
        BlocProvider.of<FavouritesCitiesBloc>(context);
    return Card(
      child: ListTile(
          title: Text(city.city),
          subtitle: Text(city.voivodeship),
          // trailing: IconButton(
          //     icon: Icon(Icons.delete),
          //     onPressed: () => _onRemoveCityPressed(context, model, city)),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MeteogramScreen(city: city)))),
    );
  }
}

class CitySearchDelegate extends SearchDelegate {
  FavouriteCityModel _model;

  CitySearchDelegate(this._model);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Search term must be longer than two letters."),
          )
        ],
      );
    }

    List<City> cities = _model.searchCities(query);

    return ListView.separated(
        itemCount: cities.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index].city),
            subtitle: Text(cities[index].voivodeship),
            trailing: IconButton(
                icon: Icon(_model.contains(cities[index])
                    ? Icons.star
                    : Icons.star_border),
                onPressed: () => _onCityPressed(context, cities[index])),
            onTap: () => _onCityPressed(context, cities[index]),
          );
        });
  }

  void _onCityPressed(BuildContext context, City city) {
    if (!_model.contains(city)) {
      _model.add(city);
    }
    close(context, null);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
