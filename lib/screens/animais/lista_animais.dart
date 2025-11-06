import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../database/dao/animal_dao.dart';
import '../../models/animal.dart';
import '../../components/health_card.dart';
import 'formulario_animal.dart';
import 'perfil_animal.dart';
import '../status_database/status_database.dart';

class ListaAnimaisScreen extends StatefulWidget {
  const ListaAnimaisScreen({super.key});

  @override
  State<ListaAnimaisScreen> createState() => _ListaAnimaisScreenState();
}

class _ListaAnimaisScreenState extends State<ListaAnimaisScreen> {
  final AnimalDao _animalDao = AnimalDao();

  Future<void> _refreshAnimais() async {
    setState(() {});
  }

  Future<void> _deleteAnimal(int id, String identificacao) async {
    bool? confirmado = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem certeza que deseja excluir o animal $identificacao?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      await _animalDao.delete(id);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$identificacao excluído com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(Icons.agriculture, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                'Gestão Pecuária',
                style: GoogleFonts.interTight(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.analytics, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StatusDatabaseScreen()),
                );
              },
              tooltip: 'Status do Banco',
            ),
          ],
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Card de Introdução
                _buildIntroCard(),
                const SizedBox(height: 16),
                // Lista de Animais
                Expanded(
                  child: FutureBuilder<List<Animal>>(
                    future: _animalDao.findAll(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildLoadingState();
                      }

                      if (snapshot.hasError) {
                        return _buildErrorState(snapshot.error.toString());
                      }

                      final animais = snapshot.data ?? [];

                      if (animais.isEmpty) {
                        return _buildEmptyState();
                      }

                      return _buildAnimaisList(animais);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FormularioAnimalScreen()),
            ).then((_) => _refreshAnimais());
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8F5E8), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.pets, color: Colors.green, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    'Gestão do Rebanho',
                    style: GoogleFonts.interTight(
                      color: const Color(0xFF2E7D32),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Gerencie todos os animais do seu rebanho. Cadastre novos animais, visualize detalhes e acompanhe a saúde do rebanho.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF666666),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.green),
          const SizedBox(height: 16),
          Text(
            'Carregando animais...',
            style: GoogleFonts.inter(
              color: const Color(0xFF666666),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Erro ao carregar animais',
            style: GoogleFonts.inter(
              color: const Color(0xFF666666),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: GoogleFonts.inter(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _refreshAnimais,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Tentar Novamente', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pets, size: 80, color: Color(0xFFCCCCCC)),
          const SizedBox(height: 16),
          Text(
            'Nenhum animal cadastrado',
            style: GoogleFonts.inter(
              color: const Color(0xFF666666),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Comece cadastrando o primeiro animal do seu rebanho',
            style: GoogleFonts.inter(
              color: const Color(0xFF999999),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormularioAnimalScreen()),
              ).then((_) => _refreshAnimais());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add),
                const SizedBox(width: 8),
                Text('Cadastrar Animal', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimaisList(List<Animal> animais) {
    return RefreshIndicator(
      onRefresh: _refreshAnimais,
      backgroundColor: Colors.white,
      color: Colors.green,
      child: ListView.builder(
        itemCount: animais.length,
        itemBuilder: (context, index) {
          final animal = animais[index];
          return HealthCard(
            animal: animal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilAnimalScreen(
                    animal: animal,
                    animalIndex: index,
                  ),
                ),
              ).then((_) => _refreshAnimais());
            },
            onDelete: () => _deleteAnimal(animal.id!, animal.identificacao),
          );
        },
      ),
    );
  }
}