import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app_submission_1/data/api/api_service.dart';
import 'package:restaurant_app_submission_1/data/model/review_restaurant.dart';

enum ResourceReviewRestaurantState { loading, success, error, none }

class ReviewRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewRestaurantProvider({required this.apiService});

  late ReviewRestaurantResult _searchResult;

  String _message = '';
  ResourceReviewRestaurantState _state = ResourceReviewRestaurantState.none;

  String get message => _message;

  ResourceReviewRestaurantState get state => _state;

  ReviewRestaurantResult get searchResult => _searchResult;

  Future<dynamic> postReview(
    String restaurantId,
    String name,
    String review,
  ) async {
    try {
      _state = ResourceReviewRestaurantState.loading;
      notifyListeners();

      final data = await apiService.postReview(
        restaurantId: restaurantId,
        name: name,
        review: review,
      );
      _state = ResourceReviewRestaurantState.success;
      notifyListeners();
      return _searchResult = data;
    } on SocketException catch (_) {
      _state = ResourceReviewRestaurantState.error;
      notifyListeners();
      return _message =
          "Problem with your internet connection, please try again.";
    } catch (e) {
      _state = ResourceReviewRestaurantState.error;
      notifyListeners();
      return _message = "Error: $e";
    }
  }
}
