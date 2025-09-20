import 'package:intl/intl.dart';

class Boi {
  String nome;
  double peso;
  int numeroBrinco;
  DateTime dataCadastro;

  Boi(this.nome, this.peso, this.numeroBrinco, {DateTime? data})
    : dataCadastro = data ?? DateTime.now();

  String get pesoFormatado => NumberFormat("#,##0.00", "pt_BR").format(peso);

  String get dataFormatada => DateFormat("dd/MM/yyyy").format(dataCadastro);

  @override
  String toString() {
    return "Boi {nome: $nome, peso: $pesoFormatado, numeroBrinco: $numeroBrinco, data: $dataFormatada}";
  }
}
