import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/repositories/favorites_repository.dart';
import '/widgets/currency_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moedas Favoritas"),
      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Consumer<FavoritesRepository>(
          builder: (context, favorites, child) {
            return favorites.list.isEmpty
                ? ListTile(
                    leading: Icon(Icons.star),
                    title: Text(
                      "Você não tem nenhuma moeda favorita...",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : ListView.builder(
                    itemCount: favorites.list.length,
                    itemBuilder: (_, index) {
                      return CurrencyCard(currency: favorites.list[index]);
                    });
          },
        ),
      ),
    );
  }
}
