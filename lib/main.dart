import 'package:crypto_currencies/configs/app_settings.dart';
import 'package:crypto_currencies/repositories/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/repositories/favorites_repository.dart';
import 'configs/hive_config.dart';
import '/config.dart';
import 'app.dart';

void main() async {
  initConfigurations();
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountRepository()),
        ChangeNotifierProvider(create: (context) => FavoritesRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
      ],
      child: App(),
    ),
  );
}
