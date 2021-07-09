import 'package:crypto_currencies/controllers/theme.controller.dart';
import 'package:flutter/material.dart';

import '/screens/home.screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.loadThemeMode(); // Carrega instancia

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cripto Moedas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.grey,
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black45,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurpleAccent[100],
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
