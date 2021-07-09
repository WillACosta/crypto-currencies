import 'dart:collection';

import 'package:crypto_currencies/adapters/currency_hive_adapter.dart';
import 'package:crypto_currencies/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Currency> _favoritesList = [];
  late LazyBox box;

  FavoritesRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritesOfLocalStorage();
  }

  _openBox() async {
    Hive.registerAdapter(
        CurrencyHiveAdapter()); // Cria um adaptar para adicionar valores complexos com o Hive
    box = await Hive.openLazyBox<Currency>("favorites_currencies");
  }

  _readFavoritesOfLocalStorage() {
    box.keys.forEach((element) async {
      Currency currency = await box.get(element);
      _favoritesList.add(currency);
      notifyListeners();
    });
  }

  UnmodifiableListView<Currency> get list =>
      UnmodifiableListView(_favoritesList);

  saveAll(List<Currency> currencies) {
    currencies.forEach((element) {
      if (!_favoritesList
          .any((current) => current.abbreviation == element.abbreviation))
        _favoritesList.add(element);

      box.put(element.abbreviation, element); // Salva moeda no local
    });

    notifyListeners();
  }

  remove(Currency currency) {
    _favoritesList.remove(currency);
    box.delete(currency.abbreviation);
    notifyListeners();
  }
}
