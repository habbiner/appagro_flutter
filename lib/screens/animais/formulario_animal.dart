import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../database/dao/animal_dao.dart';
import '../../models/animal.dart';
import '../../components/animal_editor.dart';

class FormularioAnimalScreen extends StatefulWidget {
  final Animal? animalParaEditar;
  final int? animalIndex;

  const FormularioAnimalScreen({
    super.key,
    this.animalParaEditar,
    this.animalIndex,
  });

  @override
  State<FormularioAnimalScreen> createState() => _FormularioAnimalScreenState();
}

class _FormularioAnimalScreenState extends State<FormularioAnimalScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _identificacaoController = TextEditingController();
  final TextEditingController _racaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _observacoesController = TextEditingController();

  String _selectedSexo = 'Macho';
  String _selectedStatus = 'Saudável';
  final AnimalDao _animalDao = AnimalDao();

  bool get _isEditando => widget.animalParaEditar != null;

  @override
  void initState() {
    super.initState();
    
    if (_isEditando) {
      final animal = widget.animalParaEditar!;
      _identificacaoController.text = animal.identificacao;
      _racaController.text = animal.raca;
      _pesoController.text = animal.peso.toString();
      _dataNascimentoController.text = DateFormat('dd/MM/yyyy').format(animal.dataNascimento);
      _observacoesController.text = animal.observacoes;
      _selectedSexo = animal.sexo;
      _selectedStatus = animal.statusSaude;
    } else {
      _dataNascimentoController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _isEditando 
          ? widget.animalParaEditar!.dataNascimento 
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dataNascimentoController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _salvarAnimal() async {
    if (_formKey.currentState!.validate()) {
      try {
        final animal = Animal(
          id: _isEditando ? widget.animalParaEditar!.id : null,
          identificacao: _identificacaoController.text,
          raca: _racaController.text,
          peso: double.parse(_pesoController.text),
          dataNascimento: DateFormat('dd/MM/yyyy').parse(_dataNascimentoController.text),
          sexo: _selectedSexo,
          statusSaude: _selectedStatus,
          ultimoCuidado: _isEditando ? widget.animalParaEditar!.ultimoCuidado : DateTime.now(),
          observacoes: _observacoesController.text,
        );

        if (_isEditando) {
          await _animalDao.update(animal);
        } else {
          await _animalDao.save(animal);
        }
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_isEditando 
                  ? 'Animal atualizado com sucesso!' 
                  : 'Animal cadastrado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao salvar: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
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
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              Icon(_isEditando ? Icons.edit : Icons.add, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Text(
                _isEditando ? 'Editar Animal' : 'Cadastrar Animal',
                style: GoogleFonts.interTight(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // Card de Introdução
                _buildIntroCard(),
                const SizedBox(height: 16),
                
                // Formulário
                Card(
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
                      child: Form(
                        key: _formKey,
                        child: AnimalEditor(
                          identificacaoController: _identificacaoController,
                          racaController: _racaController,
                          pesoController: _pesoController,
                          dataNascimentoController: _dataNascimentoController,
                          observacoesController: _observacoesController,
                          selectedSexo: _selectedSexo,
                          selectedStatus: _selectedStatus,
                          onSexoChanged: (value) => setState(() => _selectedSexo = value!),
                          onStatusChanged: (value) => setState(() => _selectedStatus = value!),
                          onDataNascimentoTap: _selectDate,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Botão Salvar
                _buildSaveButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
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
                  Icon(
                    _isEditando ? Icons.edit_note : Icons.add_circle,
                    color: Colors.green,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _isEditando ? 'Editar Animal' : 'Novo Animal',
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
                _isEditando 
                    ? 'Atualize as informações do animal abaixo'
                    : 'Preencha as informações do novo animal do rebanho',
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

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _salvarAnimal,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_isEditando ? Icons.save : Icons.add, size: 20),
            const SizedBox(width: 8),
            Text(
              _isEditando ? 'Salvar Alterações' : 'Cadastrar Animal',
              style: GoogleFonts.interTight(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}