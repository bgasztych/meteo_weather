import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_weather/favourites_city_model.dart';
import 'package:meteo_weather/models/city.dart';
import 'package:photo_view/photo_view.dart';

import 'blocs/blocs.dart';
import 'widgets/delete_confirmation_dialog.dart';

class MeteogramScreen extends StatefulWidget {
  final City city;

  bool isLegendVisible = true;

  static const double LEGEND_PERCENT_WIDTH = 0.307692307692;
  static const double METEOGRAM_PERCENT_WIDTH = 0.692307692308;

  MeteogramScreen({Key key, @required this.city}) : super(key: key);

  @override
  _MeteogramScreenState createState() => _MeteogramScreenState();
}

class _MeteogramScreenState extends State<MeteogramScreen> {
  FavouritesCitiesBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = _bloc ?? BlocProvider.of<FavouritesCitiesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.city),
        actions: [
          IconButton(
              icon: Icon(Icons.map),
              onPressed: () => setState(
                  () => widget.isLegendVisible = !widget.isLegendVisible)),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    DeleteConfirmationDialog(deleteCallback: () {
                      _bloc.add(FavouritesCitiesRemoved(widget.city));
                      Navigator.pop(context);
                    })),
          )
        ],
      ),
      body:
          widget.isLegendVisible ? _meteogramWithLegend(context) : _meteogram(),
    );
  }
}

Widget _meteogramWithLegend(BuildContext context) {
  return PhotoView.customChild(
    backgroundDecoration: BoxDecoration(color: Colors.white),
    child: Row(
      children: [
        Image(
          image: AssetImage('lib/resources/images/legend.png'),
          width: MediaQuery.of(context).size.width *
              MeteogramScreen.LEGEND_PERCENT_WIDTH,
        ),
        Image(
          image: AssetImage('lib/resources/images/meteogram.png'),
          width: MediaQuery.of(context).size.width *
              MeteogramScreen.METEOGRAM_PERCENT_WIDTH,
        ),
      ],
    ),
  );
}

Widget _meteogram() {
  return PhotoView(
    backgroundDecoration: BoxDecoration(color: Colors.white),
    imageProvider: AssetImage('lib/resources/images/meteogram.png'),
  );
}
