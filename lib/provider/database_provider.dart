import 'package:flutter/foundation.dart';
import 'package:restaurant_app_submission_1/data/local/db/database_helper.dart';
import 'package:restaurant_app_submission_1/data/model/list_restaurant.dart';

enum LocalResourceState { loading, noData, hasData, error }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late LocalResourceState _state;

  String _message = '';
  LocalResourceState get state => _state;

  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    try {
      _state = LocalResourceState.loading;
      _favorites = await databaseHelper.getFavorites();

      if (_favorites.isNotEmpty) {
        _state = LocalResourceState.hasData;
      } else {
        _state = LocalResourceState.noData;
        _message = 'No favorited restaurant';
      }

      notifyListeners();
    } catch (e) {
      _state = LocalResourceState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  void addBookmark(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = LocalResourceState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant =
        await databaseHelper.getFavoriteRestaurantById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = LocalResourceState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
