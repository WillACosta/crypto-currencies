import 'package:crypto_currencies/repositories/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesRepository(),
      child: App(),
    ),
  );
}
