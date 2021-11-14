import 'dart:async';

import 'package:movies/movies.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tvseries/tvseries.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _categoryMovies = 'movies';
  static const String _categoryTVSeries = 'tvSeries';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(
      {MovieTable? movie, TVSeriesTable? tvSeries}) async {
    final db = await database;
    if (movie != null) {
      return await db!.insert(_tblWatchlist, movie.toJson());
    } else {
      return await db!.insert(_tblWatchlist, tvSeries!.toJson());
    }
  }

  Future<int> removeWatchlist(
      {MovieTable? movie, TVSeriesTable? tvSeries}) async {
    final db = await database;
    if (movie != null) {
      return await db!.delete(
        _tblWatchlist,
        where: 'id = ? AND category = ?',
        whereArgs: [movie.id, _categoryMovies],
      );
    } else {
      return await db!.delete(
        _tblWatchlist,
        where: 'id = ? AND category = ?',
        whereArgs: [tvSeries!.id, _categoryTVSeries],
      );
    }
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ? AND category = ?',
      whereArgs: [id, _categoryMovies],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTVSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ? AND category = ?',
      whereArgs: [id, _categoryTVSeries],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblWatchlist,
      where: 'category = ?',
      whereArgs: [_categoryMovies],
    );

    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTVSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblWatchlist,
      where: 'category = ?',
      whereArgs: [_categoryTVSeries],
    );

    return results;
  }
}
