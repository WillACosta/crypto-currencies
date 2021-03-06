import 'package:crypto_currencies/configs/app_settings.dart';
import 'package:crypto_currencies/controllers/theme.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/currency.dart';
import '../repositories/currency_repository.dart';
import '/screens/currency_detail.screen.dart';
import '/repositories/favorites_repository.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final currenciesList = CurrencyRepository.tabela;
  late NumberFormat real;
  late Map<String, String> localeObject;
  List<Currency> currencySelected = [];
  late FavoritesRepository favorites;
  var controller = ThemeController.to;

  readNumberFormat() {
    localeObject = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(
      locale: localeObject['locale'],
      name: localeObject['name'],
    );
  }

  PopupMenuItem changeLanguageButton() {
    final locale = localeObject['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = localeObject['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuItem(
      child: ListTile(
        leading: Icon(Icons.swap_vert),
        title: Text("Usar $locale"),
        onTap: () {
          context.read<AppSettings>().setLocale(locale, name);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // favorites = Provider.of<FavoritesRepository>(context);
    favorites = context.watch<FavoritesRepository>();

    readNumberFormat();

    dynamicAppBar() {
      if (currencySelected.isEmpty) {
        return AppBar(
          title: Text("Cripto Moedas"),
          actions: [
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: ListTile(
                    leading: Obx(
                      () => controller.isDark.value
                          ? Icon(Icons.brightness_7)
                          : Icon(Icons.brightness_2),
                    ),
                    title: Obx(() =>
                        controller.isDark.value ? Text('Light') : Text("Dark")),
                    onTap: () => controller.changeTheme(),
                  ),
                ),
                changeLanguageButton(),
              ],
              icon: Icon(Icons.more_vert),
            ),
          ],
        );
      } else {
        return AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                currencySelected = [];
              });
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            currencySelected.length == 1
                ? '${currencySelected.length} selecionada'
                : '${currencySelected.length} selecionadas',
          ),
          backgroundColor: Colors.blueGrey[50],
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black87),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }

    void showDetails(Currency moeda) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CurrencyDetailScreen(currency: moeda),
        ),
      );
    }

    void cleanSelected() {
      setState(() {
        currencySelected = [];
      });
    }

    return Scaffold(
      appBar: dynamicAppBar(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: currencySelected.contains(currenciesList[moeda])
                ? CircleAvatar(child: Icon(Icons.check))
                : SizedBox(
                    child: Image.asset(currenciesList[moeda].icon),
                    width: 40,
                  ),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    currenciesList[moeda].name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (favorites.list.any((currency) =>
                    currency.abbreviation ==
                    currenciesList[moeda].abbreviation))
                  Icon(Icons.circle, color: Colors.amber, size: 8)
              ],
            ),
            trailing: Text(real.format(currenciesList[moeda].price)),
            selected: currencySelected.contains(currenciesList[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                currencySelected.contains(currenciesList[moeda])
                    ? currencySelected.remove(currenciesList[moeda])
                    : currencySelected.add(currenciesList[moeda]);
              });
            },
            onTap: () => showDetails(currenciesList[moeda]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: currenciesList.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: currencySelected.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favorites.saveAll(currencySelected);
                cleanSelected();
              },
              icon: Icon(Icons.star),
              label: Text(
                "FAVORITAR",
                style: TextStyle(letterSpacing: 0, fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }
}
