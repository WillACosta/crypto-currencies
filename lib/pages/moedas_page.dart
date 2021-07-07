import 'package:crypto_currencies/pages/moedas_detalhes.dart';
import 'package:crypto_currencies/repositories/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/currency.dart';
import '/repositories/moeda_repository.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabelaMoedas = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> selecionadas = [];
  late FavoritesRepository favorites;

  @override
  Widget build(BuildContext context) {
    // Duas formas de obter a instancia do provider
    // favorites = Provider.of<FavoritesRepository>(context);
    favorites = context.watch<FavoritesRepository>();

    appBarDinamica() {
      if (selecionadas.isEmpty) {
        return AppBar(
          title: Text("Cripto Moedas"),
        );
      } else {
        return AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                selecionadas = [];
              });
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('${selecionadas.length} selecionadas'),
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

    void mostrarDetalhes(Moeda moeda) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MoedasDetalhesPage(moeda: moeda)),
      );
    }

    void limparSelecionadas() {
      setState(() {
        selecionadas = [];
      });
    }

    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: selecionadas.contains(tabelaMoedas[moeda])
                ? CircleAvatar(child: Icon(Icons.check))
                : SizedBox(
                    child: Image.asset(tabelaMoedas[moeda].icone),
                    width: 40,
                  ),
            title: Row(
              children: [
                Text(
                  tabelaMoedas[moeda].nome,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (favorites.list.contains(tabelaMoedas[moeda]))
                  Icon(Icons.circle, color: Colors.amber, size: 8)
              ],
            ),
            trailing: Text(real.format(tabelaMoedas[moeda].preco)),
            selected: selecionadas.contains(tabelaMoedas[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                selecionadas.contains(tabelaMoedas[moeda])
                    ? selecionadas.remove(tabelaMoedas[moeda])
                    : selecionadas.add(tabelaMoedas[moeda]);
              });
            },
            onTap: () => mostrarDetalhes(tabelaMoedas[moeda]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: tabelaMoedas.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favorites.saveAll(selecionadas);
                limparSelecionadas();
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
