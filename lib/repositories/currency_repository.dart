import '../models/currency.dart';

class CurrencyRepository {
  static List<Currency> tabela = [
    Currency(
      icon: "images/bitcoin.png",
      name: "Bitcoin",
      abbreviation: "BTC",
      price: 164603.00,
    ),
    Currency(
      icon: "images/ethereum.png",
      name: "Ethereum",
      abbreviation: "ETH",
      price: 9716.00,
    ),
    Currency(
      icon: "images/xrp.png",
      name: "XRP",
      abbreviation: "XRP",
      price: 3.34,
    ),
    Currency(
      icon: "images/cardano.png",
      name: "Cardano",
      abbreviation: "ADA",
      price: 6.32,
    ),
    Currency(
      icon: "images/usdcoin.png",
      name: "USD Coin",
      abbreviation: "USDC",
      price: 5.02,
    ),
    Currency(
      icon: "images/litecoin.png",
      name: "LiteCoin",
      abbreviation: "LTC",
      price: 669.93,
    ),
  ];
}
