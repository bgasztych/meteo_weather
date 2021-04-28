import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_weather/widgets/delete_confirmation_dialog.dart';

import '../blocs/blocs.dart';
import '../i18n.dart';
import '../models/city.dart';
import 'meteogram_screen.dart';

class FavouritesCitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavouritesCitiesBloc _favouriteCitiesBloc =
        BlocProvider.of<FavouritesCitiesBloc>(context);
    final FilteredCitiesBloc _filteredCitiesBloc =
        BlocProvider.of<FilteredCitiesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).favourites),
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
          // TODO Delete
          IconButton(
            icon: Icon(Icons.animation),
            onPressed: () async {
              _filteredCitiesBloc.repository.getCity(983);
            },
          ),
        ],
      ),
      body: BlocBuilder<FavouritesCitiesBloc, FavouritesCitiesState>(
          bloc: _favouriteCitiesBloc,
          builder: (context, state) {
            if (state is FavouritesCitiesLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is FavouritesCitiesSuccess) {
              if (state.cities.isEmpty) {
                return Center(child: Text(I18n.of(context).noFavouritesCities));
              }
              return ListView.builder(
                itemCount: state.cities.length,
                itemBuilder: (BuildContext context, int index) =>
                    FavouriteCityWidget(city: state.cities[index]),
              );
            }
            if (state is FavouritesCitiesFailure) {
              return Center(child: Text(I18n.of(context).fetchFavouritesCitiesFailed));
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
                  builder: (context) => DeleteConfirmationDialog(
                      deleteCallback: () =>
                          _bloc.add(FavouritesCitiesRemoved(city))),
                )),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                    value: _bloc,
                    child: MeteogramScreen(city: city),
                  )),
        ),
      ),
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
            child: Text(I18n.of(context).searchQueryTooShort),
          )
        ],
      );
    }

    filteredBloc.add(FilteredCitiesFiltered(query));

    return BlocBuilder(
        bloc: filteredBloc,
        // ignore: missing_return
        builder: (context, state) {
          if (state is FilteredCitiesLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FilteredCitiesSuccess) {
            if (state.cities.isEmpty) {
              return Center(child: Text(I18n.of(context).searchNoResults));
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
            return Center(child: Text(I18n.of(context).searchCitiesFetchFailed));
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
