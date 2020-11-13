
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_weather/meteogram_screen.dart';

import 'blocs/blocs.dart';
import 'models/city.dart';

class FavouritesCitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavouritesCitiesBloc _favouriteCitiesBloc =
        BlocProvider.of<FavouritesCitiesBloc>(context);
    final FilteredCitiesBloc _filteredCitiesBloc =
        BlocProvider.of<FilteredCitiesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await showSearch<City>(
                  context: context,
                  delegate: CitySearchDelegate(_filteredCitiesBloc));
              if (city != null) {
                _favouriteCitiesBloc.add(FavouritesCitiesAdded(city));
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<FavouritesCitiesBloc, FavouritesCitiesState>(
          cubit: _favouriteCitiesBloc,
          builder: (context, state) {
            if (state is FavouritesCitiesLoading) {
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
            return Container();
          }),
    );
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
          trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => showDialog(
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
                                _bloc.add(FavouritesCitiesRemoved(city));
                                Navigator.pop(context);
                              },
                              child: Text("Remove"))
                        ],
                      ))),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MeteogramScreen(city: city)))),
    );
  }
}

class CitySearchDelegate extends SearchDelegate<City> {
  final Bloc<FilteredCitiesEvent, FilteredCitiesState> filteredBloc;

  CitySearchDelegate(this.filteredBloc);

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

    filteredBloc.add(FilteredCitiesFiltered(query));

    return BlocBuilder(
        cubit: filteredBloc,
        // ignore: missing_return
        builder: (context, state) {
          if (state is FilteredCitiesLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FilteredCitiesSuccess) {
            if (state.cities.isEmpty) {
              return Center(child: Text("No results found"));
            }
            return ListView.separated(
                itemCount: state.cities.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.cities[index].city),
                    subtitle: Text(state.cities[index].voivodeship),
                    // trailing: IconButton(
                    //     icon: Icon(_model.contains(cities[index])
                    //         ? Icons.star
                    //         : Icons.star_border),
                    //     onPressed: () => _onCityPressed(context, cities[index])),
                    onTap: () => close(context, state.cities[index]),
                  );
                });
          }
          if (state is FilteredCitiesFailure) {
            return Center(child: Text("Failed to fetch filtered cities"));
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
