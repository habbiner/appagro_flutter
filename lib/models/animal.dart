class Animal {
  int? id;
  String identificacao;
  String raca;
  double peso;
  DateTime dataNascimento;
  String sexo;
  String statusSaude;
  DateTime ultimoCuidado;
  String observacoes;

  Animal({
    this.id,
    required this.identificacao,
    required this.raca,
    required this.peso,
    required this.dataNascimento,
    required this.sexo,
    required this.statusSaude,
    required this.ultimoCuidado,
    this.observacoes = '',
  });

  // Método para converter para Map (simula o toMap do Hive)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'identificacao': identificacao,
      'raca': raca,
      'peso': peso,
      'data_nascimento': dataNascimento.toIso8601String(),
      'sexo': sexo,
      'status_saude': statusSaude,
      'ultimo_cuidado': ultimoCuidado.toIso8601String(),
      'observacoes': observacoes,
    };
  }

  // Factory para criar Animal a partir de Map
  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      id: map['id'],
      identificacao: map['identificacao'],
      raca: map['raca'],
      peso: map['peso'] is int ? (map['peso'] as int).toDouble() : map['peso'],
      dataNascimento: DateTime.parse(map['data_nascimento']),
      sexo: map['sexo'],
      statusSaude: map['status_saude'],
      ultimoCuidado: DateTime.parse(map['ultimo_cuidado']),
      observacoes: map['observacoes'] ?? '',
    );
  }
}