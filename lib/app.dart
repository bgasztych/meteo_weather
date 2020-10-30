import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_weather/blocs/bloc.dart';
import 'package:meteo_weather/favourites_city_model.dart';
import 'package:meteo_weather/repositories/providers/local_city_provider.dart';
import 'package:meteo_weather/repositories/repository.dart';
import 'package:provider/provider.dart';

import 'favourites_cities_screen.dart';

class MeteoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(LocalCityProvider()),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: "Meteo App",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BlocProvider(
              create: (context) => FavouritesCitiesBloc(
                  RepositoryProvider.of<Repository>(context))
                ..add(FavouritesCitiesFetched()),
              child: FavouritesCitiesScreen()),
        );
      }),
    );
  }
}