import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app_submission_1/data/api/api_service.dart';
import 'package:restaurant_app_submission_1/data/model/detail_restaurant.dart';

enum ResourceState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({
    required this.apiService,
    required String restaurantId,
  }) {
    fetchDetailRestaurant(restaurantId);
  }

  late DetailRestaurantResult _detailRestaurantResult;

  String _message = '';
  late ResourceState _state;

  String get message => _message;

  ResourceState get state => _state;

  DetailRestaurantResult get restaurantsResult => _detailRestaurantResult;

  Future<dynamic> fetchDetailRestaurant(String restaurantId) async {
    try {
      _state = ResourceState.loading;
      notifyListeners();

      final data = await apiService.detailRestaurant(restaurantId);
      _state = ResourceState.hasData;
      notifyListeners();
      return _detailRestaurantResult = data;
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
