class Cuidado {
  int? id;
  int animalId;
  String tipo;
  String descricao;
  DateTime dataCuidado;
  DateTime? proximoCuidado;
  String observacoes;

  Cuidado({
    this.id,
    required this.animalId,
    required this.tipo,
    required this.descricao,
    required this.dataCuidado,
    this.proximoCuidado,
    this.observacoes = '',
  });

  // Método para converter para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'animal_id': animalId,
      'tipo': tipo,
      'descricao': descricao,
      'data_cuidado': dataCuidado.toIso8601String(),
      'proximo_cuidado': proximoCuidado?.toIso8601String(),
      'observacoes': observacoes,
    };
  }

  // Factory para criar Cuidado a partir de Map
  factory Cuidado.fromMap(Map<String, dynamic> map) {
    return Cuidado(
      id: map['id'],
      animalId: map['animal_id'],
      tipo: map['tipo'],
      descricao: map['descricao'],
      dataCuidado: DateTime.parse(map['data_cuidado']),
      proximoCuidado: map['proximo_cuidado'] != null 
          ? DateTime.parse(map['proximo_cuidado']) 
          : null,
      observacoes: map['observacoes'] ?? '',
    );
  }
}