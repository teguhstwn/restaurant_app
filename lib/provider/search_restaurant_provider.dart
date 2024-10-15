import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app_submission_1/data/api/api_service.dart';
import 'package:restaurant_app_submission_1/data/model/search_restaurant.dart';

enum ResourceState { loading, hasData, noData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService, required String query}) {
    searchRestaurant(query);
  }

  late SearchRestaurantResult _searchResult;

  String _message = '';
  late ResourceState _state;

  String get message => _message;
  ResourceState get state => _state;

  SearchRestaurantResult get searchResult => _searchResult;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      final data = await apiService.searchRestaurant(query);
      if (data.restaurants.isEmpty) {
        _state = ResourceState.noData;
        notifyListeners();
        return _message = "Restaurant not found, try other keyword.";
      } else {
        _state = ResourceState.hasData;
        notifyListeners();
        return _searchResult = data;
      }
    } on SocketException catch (_) {
      _state = ResourceState.error;
      notifyListeners();
      return _message =
          "Problem with your internet connection, please try again.";
    } catch (e) {
      _state = ResourceState.error;
      notifyListeners();
      return _message = "Error: $e";
    }
  }
}
