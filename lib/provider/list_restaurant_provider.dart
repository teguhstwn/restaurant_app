import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app_submission_1/data/api/api_service.dart';
import 'package:restaurant_app_submission_1/data/model/list_restaurant.dart';

enum ResourceState { loading, noData, hasData, error }

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    _fetchRestaurants();
  }

  late RestaurantResult _restaurantResult;

  String _message = '';
  late ResourceState _state;

  String get message => _message;
  ResourceState get state => _state;

  RestaurantResult get restaurantsResult => _restaurantResult;

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      final data = await apiService.listRestaurant();
      if (data.restaurants.isEmpty) {
        _state = ResourceState.noData;
        notifyListeners();
        return _message = "Empty data";
      } else {
        _state = ResourceState.hasData;
        notifyListeners();
        return _restaurantResult = data;
      }
    } on SocketException catch (_) {
      _state = ResourceState.error;
      notifyListeners();
      return _message =
          "Problem with your internet connection, please try again";
    } catch (e) {
      _state = ResourceState.error;
      notifyListeners();
      return _message = "Error: $e";
    }
  }
}
