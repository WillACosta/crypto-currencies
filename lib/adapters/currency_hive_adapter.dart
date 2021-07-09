import 'package:crypto_currencies/models/currency.dart';
import 'package:hive/hive.dart';

class CurrencyHiveAdapter extends TypeAdapter<Currency> {
  @override
  final typeId = 0;

  @override
  Currency read(BinaryReader reader) {
    return Currency(
      icon: reader.readString(),
      name: reader.readString(),
      abbreviation: reader.readString(),
      price: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Currency obj) {
    writer.writeString(obj.icon);
    writer.writeString(obj.name);
    writer.writeString(obj.abbreviation);
    writer.writeDouble(obj.price);
  }
}
