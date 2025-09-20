class Boi {
  String nome;
  double peso;
  int numeroBrinco;

  Boi(this.nome, this.peso, this.numeroBrinco);

  String get pesoFormatado => peso.toStringAsFixed(2);

  @override
  String toString() {
    return "Boi {nome: $nome, peso: $pesoFormatado, numeroBrinco: $numeroBrinco}";
  }
}
