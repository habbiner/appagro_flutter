import '../app_database.dart';
import '../../models/cuidado.dart';

class CuidadoDao {
  Future<int> save(Cuidado cuidado) async {
    return await AppDatabase.insertCuidado(cuidado.toMap());
  }

  Future<List<Cuidado>> findAll() async {
    final cuidadosMap = await AppDatabase.getCuidados();
    return cuidadosMap.map((map) => Cuidado.fromMap(map)).toList();
  }

  Future<int> getTotalCuidados() async {
    final estatisticas = await AppDatabase.getEstatisticas();
    return estatisticas['total_cuidados'] ?? 0;
  }
}