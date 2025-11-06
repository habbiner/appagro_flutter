import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimalEditor extends StatelessWidget {
  final TextEditingController identificacaoController;
  final TextEditingController racaController;
  final TextEditingController pesoController;
  final TextEditingController dataNascimentoController;
  final TextEditingController observacoesController;
  final String selectedSexo;
  final String selectedStatus;
  final ValueChanged<String?> onSexoChanged;
  final ValueChanged<String?> onStatusChanged;
  final VoidCallback onDataNascimentoTap;

  const AnimalEditor({
    super.key,
    required this.identificacaoController,
    required this.racaController,
    required this.pesoController,
    required this.dataNascimentoController,
    required this.observacoesController,
    required this.selectedSexo,
    required this.selectedStatus,
    required this.onSexoChanged,
    required this.onStatusChanged,
    required this.onDataNascimentoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Identificação
        _buildInputField(
          'Identificação',
          'Ex: BR001, N123',
          identificacaoController,
          Icons.numbers,
        ),
        const SizedBox(height: 16),
        
        // Raça
        _buildInputField(
          'Raça',
          'Ex: Nelore, Angus, Hereford',
          racaController,
          Icons.pets,
        ),
        const SizedBox(height: 16),
        
        // Peso
        _buildInputField(
          'Peso (kg)',
          'Ex: 350.5',
          pesoController,
          Icons.monitor_weight,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        
        // Data de Nascimento
        _buildDateField(),
        const SizedBox(height: 16),
        
        // Sexo e Status (em linha)
        Row(
          children: [
            Expanded(child: _buildSexoField()),
            const SizedBox(width: 12),
            Expanded(child: _buildStatusField()),
          ],
        ),
        const SizedBox(height: 16),
        
        // Observações
        _buildObservationsField(),
      ],
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                prefixIcon: Icon(icon, color: Colors.green, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data de Nascimento',
              style: GoogleFonts.inter(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: onDataNascimentoTap,
              child: AbsorbPointer(
                child: TextField(
                  controller: dataNascimentoController,
                  decoration: InputDecoration(
                    hintText: 'Selecione a data',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    prefixIcon: const Icon(Icons.calendar_today, color: Colors.green, size: 20),
                    suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.green),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSexoField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sexo',
              style: GoogleFonts.inter(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedSexo,
                items: const [
                  DropdownMenuItem(value: 'Macho', child: Text('Macho')),
                  DropdownMenuItem(value: 'Fêmea', child: Text('Fêmea')),
                ],
                onChanged: onSexoChanged,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status de Saúde',
              style: GoogleFonts.inter(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedStatus,
                items: const [
                  DropdownMenuItem(value: 'Saudável', child: Text('Saudável')),
                  DropdownMenuItem(value: 'Em tratamento', child: Text('Em tratamento')),
                  DropdownMenuItem(value: 'Doente', child: Text('Doente')),
                ],
                onChanged: onStatusChanged,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildObservationsField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Observações',
              style: GoogleFonts.inter(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: observacoesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Observações adicionais sobre o animal...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}