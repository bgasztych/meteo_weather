import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/favourite_city_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';

class LocalCityProvider implements FavouriteCityProvider {
  static const int DB_VERSION = 1;
  static const String DB_NAME = "meteo.db";
  static const String CITIES_TABLE = "cities";

  LocalCityProvider._();

  static final LocalCityProvider instance = LocalCityProvider._();

  factory LocalCityProvider() {
    return LocalCityProvider._();
  }

  static Database _database;
  final _initDBMemoizer = AsyncMemoizer<Database>();

  Future<Database> _getDatabase() async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDBMemoizer.runOnce(() async {
      return await _initDB();
    });
    return _database;
  }

  Future<Database> _initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) async {
        await _createDbSchema(db);
      },
      version: DB_VERSION,
    );
  }

  Future<void> _createDbSchema(Database db) async {
    await db.execute("""CREATE TABLE $CITIES_TABLE (
        ${City.CITIES_ID} INTEGER PRIMARY KEY,
        ${City.CITIES_CITY} TEXT,
        ${City.CITIES_VOIVODESHIP} TEXT,
        ${City.CITIES_METEOGRAM} TEXT,
        ${City.CITIES_UPDATED_DATE} INTEGER
        )""");
  }

  @override
  Future<List<City>> getFavouritesCities() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(CITIES_TABLE);

    return _createCitiesList(maps);
  }

  List<City> _createCitiesList(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return _createCity(maps[i]);
    });
  }

  City _createCity(Map<String, dynamic> map) {
    return City(
        map[City.CITIES_ID],
        map[City.CITIES_CITY],
        map[City.CITIES_VOIVODESHIP],
        map[City.CITIES_METEOGRAM],
        DateTime.fromMillisecondsSinceEpoch(map[City.CITIES_UPDATED_DATE]));
  }

  @override
  Future<void> removeCityFromFavourites(City city) async {
    final db = await _getDatabase();
    await db.delete(
        CITIES_TABLE,
        where: "${City.CITIES_ID} = ?", whereArgs: [city.id]);
  }

  @override
  Future<void> addCityToFavourites(City city) async {
    final db = await _getDatabase();
    await db.insert(
        CITIES_TABLE, city.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<City> getFavouriteCity(int id) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db
        .query(CITIES_TABLE, where: "${City.CITIES_ID} = ?", whereArgs: [id]);

    return maps.isNotEmpty ? _createCity(maps.single) : null;
  }

  @override
  Future<DateTime> getLastUpdatedDate() async {
    final db = await _getDatabase();
    final res = await db.rawQuery(
        "SELECT min(${City.CITIES_UPDATED_DATE}) FROM $CITIES_TABLE");
    return DateTime.fromMillisecondsSinceEpoch(res.single.values.first);
  }

  @override
  Future<void> updateFavouriteCity(City city) async {
    final db = await _getDatabase();
    await db.update(
        CITIES_TABLE, city.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateFavouriteCities(List<City> cities) async {
    for (int i = 0; i < cities.length; i++) {
      await updateFavouriteCity(cities[i]);
    }
  }
}
