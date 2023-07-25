import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/exceptions/http_exception.dart';
import 'package:my_shop/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(context, String token, String userId) async {
    try {
      _toggleFavorite();

      final response = await http.put(
        Uri.parse(
            '${Constants.USER_FAVORITES_URL}/$userId/$id.json?auth=$token'),
        body: jsonEncode(isFavorite),
      );
      if (response.statusCode >= 400) {
        _toggleFavorite();
        throw HttpException(
          msg: 'Erro ao favoritar produto',
          statusCode: response.statusCode,
        );
      }
    } on HttpException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 2000),
          content: Text(error.toString()),
        ),
      );
    }
  }
}
