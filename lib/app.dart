import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_weather/repositories/providers/local_city_provider.dart';
import 'package:meteo_weather/repositories/repository.dart';

import 'blocs/blocs.dart';
import 'favourites_cities_screen.dart';
import 'i18n.dart';

class MeteoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(LocalCityProvider()),
      child: Builder(builder: (context) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MultiBlocProvider(providers: [
            BlocProvider(
                create: (context) => FavouritesCitiesBloc(
                    RepositoryProvider.of<Repository>(context))
                  ..add(FavouritesCitiesFetched())),
            BlocProvider(
                create: (context) =>
                    FilteredCitiesBloc(RepositoryProvider.of(context))),
          ], child: FavouritesCitiesScreen()),
          localizationsDelegates: [
            I18nDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: I18nDelegate.supportedLocales,
        );
      }),
    );
  }
}
