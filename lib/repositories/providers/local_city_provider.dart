import 'package:meteo_weather/models/city.dart';
import 'package:meteo_weather/repositories/providers/city_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalCityProvider implements CityProvider {
  static const int DB_VERSION = 1;
  static const String DB_NAME = "meteo.db";

  static const String CITIES_TABLE = "cities";
  static const String CITIES_ID = "id";
  static const String CITIES_CITY = "city";
  static const String CITIES_VOIVODESHIP = "voivodeship";
  static const String CITIES_METEOGRAM = "meteogram";
  static const String CITIES_UPDATED_DATE = "updated_date";
  static const String CITIES_IS_FAVOURITE = "is_favourite";

  static Database _database;

  Future<Database> _getDatabase() async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) async {
        await _createDbSchema(db);
        // TODO DELETE MOCK
        await _mockCities();
      },
      version: DB_VERSION,
    );
  }

  Future<void> _createDbSchema(Database db) async {
    await db.execute("""CREATE TABLE $CITIES_TABLE (
        $CITIES_ID INTEGER PRIMARY KEY,
        $CITIES_CITY TEXT,
        $CITIES_VOIVODESHIP TEXT,
        $CITIES_METEOGRAM TEXT,
        $CITIES_UPDATED_DATE INTEGER,
        $CITIES_IS_FAVOURITE INTEGER,
        )""");
  }

  Future<void> _mockCities() async {
    final db = await _getDatabase();

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
          cities[i].toMap()..addAll({CITIES_IS_FAVOURITE: i < 9 ? 1 : 0}),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<List<City>> getAllCities() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(CITIES_TABLE);

    return List.generate(maps.length, (i) {
      return City(
          maps[i][CITIES_ID],
          maps[i][CITIES_CITY],
          maps[i][CITIES_VOIVODESHIP],
          maps[i][CITIES_METEOGRAM],
          DateTime.fromMillisecondsSinceEpoch(maps[i][CITIES_UPDATED_DATE]));
    });
  }

  @override
  Future<List<City>> getFavouritesCities() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db
        .query(CITIES_TABLE, where: "$CITIES_IS_FAVOURITE = ?", whereArgs: [1]);

    return List.generate(maps.length, (i) {
      return City(
          maps[i][CITIES_ID],
          maps[i][CITIES_CITY],
          maps[i][CITIES_VOIVODESHIP],
          maps[i][CITIES_METEOGRAM],
          DateTime.fromMillisecondsSinceEpoch(maps[i][CITIES_UPDATED_DATE]));
    });
  }

  @override
  Future<List<City>> getFilteredCities(String query) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(CITIES_TABLE,
        where: "$CITIES_CITY LIKE ?", whereArgs: ["$query%"]);

    return List.generate(maps.length, (i) {
      return City(
          maps[i][CITIES_ID],
          maps[i][CITIES_CITY],
          maps[i][CITIES_VOIVODESHIP],
          maps[i][CITIES_METEOGRAM],
          DateTime.fromMillisecondsSinceEpoch(maps[i][CITIES_UPDATED_DATE]));
    });
  }

  @override
  Future<void> removeCityFromFavourites(City city) async {
    final db = await _getDatabase();
    await db.update(
        CITIES_TABLE, city.toMap()..addAll({CITIES_IS_FAVOURITE: 0}),
        where: "$CITIES_ID = ?", whereArgs: [city.id]);
  }

  @override
  Future<void> addCityToFavourites(City city) async {
    final db = await _getDatabase();
    await db.update(
        CITIES_TABLE, city.toMap()..addAll({CITIES_IS_FAVOURITE: 1}),
        where: "$CITIES_ID = ?", whereArgs: [city.id]);
  }
}
