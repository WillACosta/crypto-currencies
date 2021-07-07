import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import '/repositories/favorites_repository.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesRepository(),
      child: App(),
    ),
  );
}
