import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meteo_weather/favourites_city_model.dart';
import 'package:meteo_weather/logger.dart';
import 'package:meteo_weather/meteogram_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteCityModel>(
      builder: (context, favouriteCityModel, child) => Scaffold(
        appBar: AppBar(
          title: Text("Favourites"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: CitySearchDelegate(favouriteCityModel),
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: favouriteCityModel.length(),
          itemBuilder: (BuildContext context, int position) => _buildItem(
              context, favouriteCityModel, favouriteCityModel.get(position)),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, FavouriteCityModel model, City city) {
    return Card(
      child: ListTile(
        title: Text(city.city),
        subtitle: Text(city.voivodeship),
        trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _onRemoveCityPressed(context, model, city)),
        onTap: () => _onCityPressed(context, city),
      ),
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
