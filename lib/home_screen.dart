import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meteo_weather/favourites_city_model.dart';
import 'package:meteo_weather/logger.dart';
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
                onPressed: () => favouriteCityModel.add(
                    FavouriteCityModel.cities[
                        Random().nextInt(FavouriteCityModel.cities.length)])),
          ],
        ),
        body: ListView.builder(
          itemCount: favouriteCityModel.length(),
          itemBuilder: (BuildContext context, int position) =>
              _buildItem(favouriteCityModel.get(position)),
        ),
      ),
    );
  }

  Widget _buildItem(City city) {
    return Card(
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(child: Text(city.city)),
          IconButton(icon: Icon(Icons.star), onPressed: null)
        ],
      ),
    );
  }
}
