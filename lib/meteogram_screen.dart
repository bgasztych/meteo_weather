import 'package:flutter/material.dart';
import 'package:meteo_weather/favourites_city_model.dart';
import 'package:photo_view/photo_view.dart';

class MeteogramScreen extends StatelessWidget {
  final City city;

  static const double LEGEND_PERCENT_WIDTH = 0.307692307692;
  static const double METEOGRAM_PERCENT_WIDTH = 0.692307692308;

  MeteogramScreen({Key key, @required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(city.city)),
      // body: PhotoView(
      //   imageProvider: ,
      // ),
      body: PhotoView.customChild(
        backgroundDecoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Image(
              image: AssetImage('lib/resources/images/legend.png'),
              width: MediaQuery.of(context).size.width * LEGEND_PERCENT_WIDTH,
            ),
            Image(
              image: AssetImage('lib/resources/images/meteogram.png'),
              width:
                  MediaQuery.of(context).size.width * METEOGRAM_PERCENT_WIDTH,
            ),
          ],
        ),
      ),
    );
  }
}
