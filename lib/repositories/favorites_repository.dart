import 'dart:collection';

import 'package:crypto_currencies/models/currency.dart';
import 'package:flutter/material.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Moeda> _favoritesList = [];

  UnmodifiableListView<Moeda> get list => UnmodifiableListView(_favoritesList);

  saveAll(List<Moeda> currencies) {
    currencies.forEach((element) {
      if (!_favoritesList.contains(element)) _favoritesList.add(element);
    });

    notifyListeners();
  }

  remove(Moeda currency) {
    _favoritesList.remove(currency);
    notifyListeners();
  }
}
