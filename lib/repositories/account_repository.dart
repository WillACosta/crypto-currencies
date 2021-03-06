import 'package:crypto_currencies/database/db.dart';
import 'package:crypto_currencies/models/position.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AccountRepository extends ChangeNotifier {
  late Database db;
  List<Position> _wallet = [];
  double _balance = 0;

  get balance => _balance;
  List<Position> get wallet => _wallet;

  AccountRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getBalance();
  }

  _getBalance() async {
    db = await DB.instance.database;

    List account = await db.query("account", limit: 1);

    _balance = account.first['balance'];
    notifyListeners();
  }

  setBalance(double value) async {
    db = await DB.instance.database;
    db.update("account", {
      "balance": value,
    });
  }
}
