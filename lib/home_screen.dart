import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meteo_weather/city_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
        actions: [
          IconButton(
              icon: Icon(Icons.search), onPressed: () => Logger().d("search")),
        ],
      ),
      body: ListView.builder(
        itemCount: CityModel.cities.length,
        itemBuilder: (BuildContext context, int position) =>
            _buildItem(position),
      ),
    );
  }

  Widget _buildItem(int position) {
    return Card(
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(child: Text(CityModel.cities[position].city)),
          IconButton(icon: Icon(Icons.star), onPressed: null)
        ],
      ),
    );
  }
}
