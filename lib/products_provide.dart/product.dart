import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavouritestatus(String authToken,String userId) async {
    final originalVal = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = 'https://shopapp-flutter-e042e.firebaseio.com/userFavourite/$userId/$id.json?auth=$authToken';
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavourite,
          ));
      if (response.statusCode >= 400) {
        isFavourite = originalVal;
        notifyListeners();
        throw response.statusCode;
      }
    } catch (e) {
     
      isFavourite = originalVal;
      notifyListeners();
      
    }
  }
}
