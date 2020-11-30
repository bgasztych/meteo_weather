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
        // TODO DELETE MOCK
        await _mockCities(db);
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
        ${City.CITIES_UPDATED_DATE} INTEGER,
        ${City.CITIES_IS_FAVOURITE} INTEGER
        )""");
  }

  Future<void> _mockCities(Database db) async {
    List<City> cities = [
      City(0, "Wrocław", "dolnoślaskie", null, DateTime.now()),
      City(1, "Opole", "dolnoślaskie", null, DateTime.now()),
      City(2, "Warszawa", "mazowieckie", null, DateTime.now()),
      City(3, "Poznań", "wielkopolskie", null, DateTime.now()),
      City(4, "Gdańsk", "pomorskie", null, DateTime.now()),
      City(5, "Jelenia Góra", "dolnoślaskie", null, DateTime.now()),
      City(6, "Wronki", "dolnoślaskie", null, DateTime.now()),
      City(7, "Białystok", "podlaskie", null, DateTime.now()),
      City(8, "Zielona Góra", "lubuskie", null, DateTime.now()),
      City(9, "Bydgoszcz", "kujawsko-pomorskie", null, DateTime.now()),
      City(10, "Gorzów Wielkopolski", "lubuskie", null, DateTime.now()),
      City(11, "Katowice", "śląskie", null, DateTime.now()),
      City(12, "Kielce", "świętokrzyskie", null, DateTime.now()),
      City(13, "Kraków", "małopolskie", null, DateTime.now()),
      City(14, "Lublin", "lubelskie", null, DateTime.now()),
      City(15, "Łódź", "łódzkie", null, DateTime.now()),
      City(16, "Olsztyn", "warmińsko-mazurskie", null, DateTime.now()),
      City(17, "Rzeszów", "podkarpackie", null, DateTime.now()),
      City(18, "Szczecin", "zachodniopomorskie", null, DateTime.now()),
      City(19, "Toruń", "kujawsko-pomorskie", null, DateTime.now()),
    ];

    for (int i = 0; i < cities.length; i++) {
      await db.insert(CITIES_TABLE,
          cities[i].toMap()..addAll({City.CITIES_IS_FAVOURITE: i < 9 ? 1 : 0}),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<List<City>> getAllCities() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(CITIES_TABLE);

    return _createCitiesList(maps);
  }

  @override
  Future<List<City>> getFavouritesCities() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(CITIES_TABLE,
        where: "${City.CITIES_IS_FAVOURITE} = ?", whereArgs: [1]);

    return _createCitiesList(maps);
  }

  @override
  Future<List<City>> getFilteredCities(String query) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(CITIES_TABLE,
        where: "${City.CITIES_CITY} LIKE ?", whereArgs: ["$query%"]);

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
    await db.update(
        CITIES_TABLE, city.toMap()..addAll({City.CITIES_IS_FAVOURITE: 0}),
        where: "${City.CITIES_ID} = ?", whereArgs: [city.id]);
  }

  @override
  Future<void> addCityToFavourites(City city) async {
    final db = await _getDatabase();
    await db.update(
        CITIES_TABLE, city.toMap()..addAll({City.CITIES_IS_FAVOURITE: 1}),
        where: "${City.CITIES_ID} = ?", whereArgs: [city.id]);
  }

  @override
  Future<City> getCity(int id) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db
        .query(CITIES_TABLE, where: "${City.CITIES_ID} = ?", whereArgs: [id]);

    return maps.isNotEmpty ? _createCity(maps.single) : null;
  }

  @override
  Future<DateTime> getRefreshCitiesDate() async {
    final db = await _getDatabase();
    final res = await db
        .rawQuery("SELECT min(${City.CITIES_UPDATED_DATE}) FROM $CITIES_TABLE");
    return DateTime.fromMillisecondsSinceEpoch(res.single.values.first);
  }

  @override
  Future<void> addCities(List<City> cities) async {
    final db = await _getDatabase();
    for (int i = 0; i < cities.length; i++) {
      await db.insert(CITIES_TABLE, cities[i].toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
