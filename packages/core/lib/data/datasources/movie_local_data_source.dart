import 'package:core/core.dart';

import '../models/watchlist_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable watchlist);
  Future<String> removeWatchlist(WatchlistTable watchlist);
  Future<WatchlistTable?> getWatchlistById(int id);
  Future<List<WatchlistTable>> getWatchlist();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable watchlist) async {
    try {
      await databaseHelper.insertWatchlist(watchlist);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable watchlist) async {
    try {
      await databaseHelper.removeWatchlist(watchlist);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getWatchlistById(int id) async {
    final result = await databaseHelper.getWatchlistById(id);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlist() async {
    final result = await databaseHelper.getWatchlist();
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }
}
