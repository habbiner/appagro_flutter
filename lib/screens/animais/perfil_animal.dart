import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../models/animal.dart';
import 'formulario_animal.dart';

class PerfilAnimalScreen extends StatefulWidget {
  final Animal animal;
  final int animalIndex;

  const PerfilAnimalScreen({
    super.key,
    required this.animal,
    required this.animalIndex,
  });

  @override
  State<PerfilAnimalScreen> createState() => _PerfilAnimalScreenState();
}

class _PerfilAnimalScreenState extends State<PerfilAnimalScreen> {
  @override
  Widget build(BuildContext context) {
    final animal = widget.animal;
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              const Icon(Icons.pets, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Text(
                'Perfil do Animal',
                style: GoogleFonts.interTight(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: _editarAnimal,
              tooltip: 'Editar Animal',
            ),
          ],
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // Card de Identificação
                _buildIdentificationCard(animal),
                const SizedBox(height: 16),
                
                // Card de Saúde
                _buildHealthCard(animal),
                const SizedBox(height: 16),
                
                // Card de Informações Pessoais
                _buildPersonalInfoCard(animal),
                const SizedBox(height: 16),
                
                // Card de Observações (se houver)
                if (animal.observacoes.isNotEmpty) ...[
                  _buildObservationsCard(animal),
                  const SizedBox(height: 16),
                ],
                
                // Card de Estatísticas
                _buildStatisticsCard(animal),
                const SizedBox(height: 20),
                
                // Botão de Ações
                _buildActionButtons(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIdentificationCard(Animal animal) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Avatar do Animal
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Icon(
                  animal.sexo == 'Fêmea' ? Icons.female : Icons.male,
                  size: 40,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              
              Text(
                animal.identificacao,
                style: GoogleFonts.interTight(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 4),
              
              Text(
                animal.raca,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 16),
              
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _getStatusColor(animal.statusSaude).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _getStatusColor(animal.statusSaude)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(animal.statusSaude),
                      size: 16,
                      color: _getStatusColor(animal.statusSaude),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      animal.statusSaude,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(animal.statusSaude),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthCard(Animal animal) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.medical_services, color: Colors.green, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Saúde',
                    style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              _buildInfoRow('Peso', '${animal.peso} kg', Icons.monitor_weight),
              const SizedBox(height: 12),
              _buildInfoRow('Último Cuidado', 
                DateFormat('dd/MM/yyyy').format(animal.ultimoCuidado), 
                Icons.calendar_today
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard(Animal animal) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info, color: Colors.green, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Informações Pessoais',
                    style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              _buildInfoRow('Sexo', animal.sexo, Icons.female),
              const SizedBox(height: 12),
              _buildInfoRow('Data de Nascimento', 
                DateFormat('dd/MM/yyyy').format(animal.dataNascimento), 
                Icons.cake
              ),
              const SizedBox(height: 12),
              _buildInfoRow('Idade', _calcularIdade(animal.dataNascimento), Icons.timeline),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildObservationsCard(Animal animal) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.notes, color: Colors.green, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Observações',
                    style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  animal.observacoes,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF2E7D32),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsCard(Animal animal) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.analytics, color: Colors.green, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Resumo',
                    style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Peso', '${animal.peso} kg', Icons.monitor_weight),
                  _buildStatItem('Idade', _calcularIdade(animal.dataNascimento), Icons.calendar_today),
                  _buildStatItem('Status', animal.statusSaude, Icons.health_and_safety),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _editarAnimal,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.edit, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Editar Animal',
                  style: GoogleFonts.interTight(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: Colors.green),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFF2E7D32),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.green, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.interTight(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2E7D32),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: const Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Saudável': return Colors.green;
      case 'Em tratamento': return Colors.orange;
      case 'Doente': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Saudável': return Icons.check_circle;
      case 'Em tratamento': return Icons.healing;
      case 'Doente': return Icons.warning;
      default: return Icons.help;
    }
  }

  String _calcularIdade(DateTime dataNascimento) {
    final agora = DateTime.now();
    final diferenca = agora.difference(dataNascimento);
    final meses = (diferenca.inDays / 30).floor();
    
    if (meses < 12) {
      return '$meses ${meses == 1 ? 'mês' : 'meses'}';
    } else {
      final anos = (meses / 12).floor();
      final mesesRestantes = meses % 12;
      if (mesesRestantes == 0) {
        return '$anos ${anos == 1 ? 'ano' : 'anos'}';
      } else {
        return '$anos ${anos == 1 ? 'ano' : 'anos'} e $mesesRestantes ${mesesRestantes == 1 ? 'mês' : 'meses'}';
      }
    }
  }

  void _editarAnimal() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioAnimalScreen(
          animalParaEditar: widget.animal,
          animalIndex: widget.animalIndex,
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }
}