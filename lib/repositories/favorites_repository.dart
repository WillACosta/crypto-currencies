import 'dart:collection';

import 'package:crypto_currencies/models/currency.dart';
import 'package:flutter/material.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Currency> _favoritesList = [];

  UnmodifiableListView<Currency> get list => UnmodifiableListView(_favoritesList);

  saveAll(List<Currency> currencies) {
    currencies.forEach((element) {
      if (!_favoritesList.contains(element)) _favoritesList.add(element);
    });

    notifyListeners();
  }

  remove(Currency currency) {
    _favoritesList.remove(currency);
    notifyListeners();
  }
}
