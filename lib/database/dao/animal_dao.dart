import '../app_database.dart';
import '../../models/animal.dart';

class AnimalDao {
  Future<int> save(Animal animal) async {
    return await AppDatabase.insertAnimal(animal.toMap());
  }

  Future<List<Animal>> findAll() async {
    final animaisMap = await AppDatabase.getAnimais();
    return animaisMap.map((map) => Animal.fromMap(map)).toList();
  }

  Future<int> update(Animal animal) async {
    return await AppDatabase.updateAnimal(animal.id!, animal.toMap());
  }

  Future<int> delete(int id) async {
    return await AppDatabase.deleteAnimal(id);
  }

  Future<int> countByStatus(String status) async {
    final animais = await findAll();
    return animais.where((animal) => animal.statusSaude == status).length;
  }

  Future<int> getTotalAnimais() async {
    final estatisticas = await AppDatabase.getEstatisticas();
    return estatisticas['total_animais'] ?? 0;
  }
}