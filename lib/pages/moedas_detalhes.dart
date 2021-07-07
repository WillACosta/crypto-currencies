import 'package:crypto_currencies/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoedasDetalhesPage extends StatefulWidget {
  MoedasDetalhesPage({Key? key, required this.moeda}) : super(key: key);
  Moeda moeda;

  @override
  _MoedasDetalhesPageState createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;

  void comprarMoeda() {
    if (_form.currentState!.validate()) {
      // Save sale

      Navigator.pop(context);

      // Exibe um toast na parte inferior da tela
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Compra realizada com sucesso!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.moeda.nome),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image.asset(widget.moeda.icone),
                      width: 55,
                    ),
                    Container(width: 10),
                    Text(
                      real.format(widget.moeda.preco),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                        color: Colors.grey[800],
                      ),
                    )
                  ],
                ),
              ),
              quantidade > 0
                  ? SizedBox(
                      // Pega a largura total da coluna
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        child: Text(
                          "$quantidade ${widget.moeda.sigla}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.teal,
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 25),
                        padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.05),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 25),
                    ),
              Form(
                key: _form,
                child: TextFormField(
                  controller: _valor,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Valor",
                    prefixIcon: Icon(Icons.monetization_on_outlined),
                    suffixIcon: Text(
                      "reais",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Informe o valor da compra";
                    } else if (double.parse(value) < 50) {
                      return "O valor mínimo para compra é de 50 R\$";
                    }

                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      quantidade = value.isEmpty
                          ? 0
                          : double.parse(value) / widget.moeda.preco;
                    });
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: comprarMoeda,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Comprar",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
