import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:rs_books/data/brain_basket.dart';
import 'package:rs_books/data/models.dart';

// Mock recipe service that grabs sample json data to mock recipe request/response
class BrainBasketDataService {
  // Batch request that gets both today recipes and friend's feed
  Future<BrainBasketData> getData() async {
    final authors = await _getAuthors();
    final books = await _getBooks();

    return BrainBasketData(authors, books);
  }

  // Get sample explore recipes json to display in ui
  Future<List<Author>> _getAuthors() async {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 300));
    // Load json from file system
    final dataString = await _loadAsset(
      'assets/resources/authors.json',
    );
    // Decode to json
    final Map<String, dynamic> json =
        jsonDecode(dataString) as Map<String, dynamic>;
    // Go through each recipe and convert json to ExploreRecipe object.
    if (json['authors'] != null) {
      final authors = <Author>[];
      json['authors'].forEach((v) {
        authors.add(Author.fromJson(v as Map<String, dynamic>));
      });
      return authors;
    } else {
      return [];
    }
  }

  Future<List<Book>> _getBooks() async {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 300));
    // Load json from file system
    final dataString = await _loadAsset(
      'assets/resources/books.json',
    );
    // Decode to json
    final Map<String, dynamic> json =
        jsonDecode(dataString) as Map<String, dynamic>;

    if (json['books'] != null) {
      final books = <Book>[];
      json['books'].forEach((v) {
        books.add(Book.fromJson(v as Map<String, dynamic>));
      });
      return books;
    } else {
      return [];
    }
  }

  // Loads json data from file system
  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
