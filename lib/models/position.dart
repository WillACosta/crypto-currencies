import 'package:crypto_currencies/models/currency.dart';

class Position {
  Currency currency;
  double amount;

  Position({required this.currency,required this.amount});
}