// Banco de dados simulado em memória - FUNCIONA PERFEITAMENTE
class AppDatabase {
  static final List<Map<String, dynamic>> _animais = [];
  static final List<Map<String, dynamic>> _cuidados = [];
  static int _nextAnimalId = 1;
  static int _nextCuidadoId = 1;

  static const String DB_NAME = 'cuidado_pecuario.db';
  static const int DB_VERSION = 1;

  static Future<void> initialize() async {
    // Insere dados de exemplo automaticamente
    if (_animais.isEmpty) {
      await _insertSampleData();
    }
  }

  static Future<void> _insertSampleData() async {
    // Dados de exemplo REALISTAS
    _animais.addAll([
      {
        'id': _nextAnimalId++,
        'identificacao': 'BR001',
        'raca': 'Nelore',
        'peso': 350.5,
        'data_nascimento': DateTime(2023, 5, 15).toIso8601String(),
        'sexo': 'Macho',
        'status_saude': 'Saudável',
        'ultimo_cuidado': DateTime.now().toIso8601String(),
        'observacoes': 'Animal robusto, boa conformação'
      },
      {
        'id': _nextAnimalId++,
        'identificacao': 'BR002', 
        'raca': 'Angus',
        'peso': 420.0,
        'data_nascimento': DateTime(2022, 8, 20).toIso8601String(),
        'sexo': 'Fêmea',
        'status_saude': 'Em tratamento',
        'ultimo_cuidado': DateTime.now().toIso8601String(),
        'observacoes': 'Em tratamento para carrapatos'
      },
      {
        'id': _nextAnimalId++,
        'identificacao': 'BR003',
        'raca': 'Hereford',
        'peso': 380.0,
        'data_nascimento': DateTime(2023, 2, 10).toIso8601String(),
        'sexo': 'Macho',
        'status_saude': 'Saudável',
        'ultimo_cuidado': DateTime.now().toIso8601String(),
        'observacoes': 'Excelente ganho de peso'
      }
    ]);

    _cuidados.addAll([
      {
        'id': _nextCuidadoId++,
        'animal_id': 2,
        'tipo': 'Vermifugação',
        'descricao': 'Aplicação de ivermectina',
        'data_cuidado': DateTime.now().toIso8601String(),
        'proximo_cuidado': DateTime.now().add(Duration(days: 30)).toIso8601String(),
        'observacoes': 'Dose: 1ml por 50kg'
      }
    ]);
  }

  // ANIMAIS - CRUD
  static Future<List<Map<String, dynamic>>> getAnimais() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simula delay do banco
    return List.from(_animais);
  }

  static Future<int> insertAnimal(Map<String, dynamic> animal) async {
    animal['id'] = _nextAnimalId++;
    animal['ultimo_cuidado'] = DateTime.now().toIso8601String();
    _animais.add(animal);
    return animal['id'];
  }

  static Future<int> updateAnimal(int id, Map<String, dynamic> animal) async {
    final index = _animais.indexWhere((a) => a['id'] == id);
    if (index != -1) {
      animal['id'] = id;
      _animais[index] = animal;
      return 1;
    }
    return 0;
  }

  static Future<int> deleteAnimal(int id) async {
    _animais.removeWhere((animal) => animal['id'] == id);
    return 1;
  }

  // CUIDADOS - CRUD  
  static Future<List<Map<String, dynamic>>> getCuidados() async {
    await Future.delayed(Duration(milliseconds: 500));
    return List.from(_cuidados);
  }

  static Future<int> insertCuidado(Map<String, dynamic> cuidado) async {
    cuidado['id'] = _nextCuidadoId++;
    _cuidados.add(cuidado);
    return cuidado['id'];
  }

  // ESTATÍSTICAS para tela de status
  static Future<Map<String, dynamic>> getEstatisticas() async {
    final totalAnimais = _animais.length;
    final totalCuidados = _cuidados.length;
    final saudaveis = _animais.where((a) => a['status_saude'] == 'Saudável').length;
    final emTratamento = _animais.where((a) => a['status_saude'] == 'Em tratamento').length;
    final doentes = _animais.where((a) => a['status_saude'] == 'Doente').length;

    return {
      'total_animais': totalAnimais,
      'total_cuidados': totalCuidados,
      'saudaveis': saudaveis,
      'em_tratamento': emTratamento,
      'doentes': doentes,
    };
  }

  static Future<void> close() async {
    // Limpa as listas (opcional)
    // _animais.clear();
    // _cuidados.clear();
  }
}