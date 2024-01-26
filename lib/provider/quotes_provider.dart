import 'package:flutter/material.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesProvider extends ChangeNotifier {
  Set<String> favoriteQuotes = {};

  Future<void> getData() async {
    await APIHelper.apiHelper.fetchedQuote().then((value) {});
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteQuotes = Set.from(prefs.getStringList('favorites') ?? []);
  }

  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favoriteQuotes.toList());
  }

  void addToFavorites(String quoteId) {
    favoriteQuotes.add(quoteId);
    saveFavorites();
    notifyListeners();
  }

  void removeFromFavorites(String quoteId) {
    favoriteQuotes.remove(quoteId);
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(String quoteId) {
    return favoriteQuotes.contains(quoteId);
  }
}
