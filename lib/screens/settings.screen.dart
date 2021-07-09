import 'package:crypto_currencies/configs/app_settings.dart';
import 'package:crypto_currencies/repositories/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<AccountRepository>();
    // final locale = context.read<AppSettings>();
    final accountProvider = Provider.of<AccountRepository>(context);
    final localeProvider = Provider.of<AppSettings>(context);
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: Text("Saldo"),
              subtitle: Text(
                real.format(accountProvider.balance),
                style: TextStyle(fontSize: 25, color: Colors.indigo),
              ),
              trailing: IconButton(
                onPressed: updateBalance,
                icon: Icon(Icons.edit),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  updateBalance() async {
    final form = GlobalKey<FormState>();
    final value = TextEditingController();
    final account = Provider.of<AccountRepository>(context);

    value.text = account.balance.toString();

    AlertDialog dialog = AlertDialog(
      title: Text("Atulizar saldo"),
      content: Form(
        key: form,
        child: TextFormField(
          controller: value,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          validator: (value) {
            if (value!.isEmpty) return 'Informe o valor do saldo';
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            if (form.currentState!.validate()) {
              account.setBalance(double.parse(value.text));
              Navigator.pop(context);
            }
          },
          child: Text("Salvar"),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}
