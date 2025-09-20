import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/boi.dart';

class FormularioBoi extends StatefulWidget {
  final Boi? boiExistente;

  const FormularioBoi({super.key, this.boiExistente});

  @override
  State<FormularioBoi> createState() => _FormularioBoiState();
}

class _FormularioBoiState extends State<FormularioBoi> {
  late TextEditingController _nomeController;
  late TextEditingController _pesoController;
  late TextEditingController _brincoController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(
      text: widget.boiExistente?.nome ?? '',
    );
    _pesoController = TextEditingController(
      text: widget.boiExistente?.peso.toString() ?? '',
    );
    _brincoController = TextEditingController(
      text: widget.boiExistente?.numeroBrinco.toString() ?? '',
    );
  }

  void _salvarBoi() {
    final String nome = _nomeController.text.trim();
    final double? peso = double.tryParse(_pesoController.text.trim());
    final int? brinco = int.tryParse(_brincoController.text.trim());

    if (nome.isEmpty || peso == null || brinco == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos corretamente")),
      );
      return;
    }

    Boi boi;
    if (widget.boiExistente != null) {
      widget.boiExistente!.nome = nome;
      widget.boiExistente!.peso = peso;
      widget.boiExistente!.numeroBrinco = brinco;
      boi = widget.boiExistente!;
    } else {
      boi = Boi(nome, peso, brinco);
    }

    Navigator.pop(context, boi);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.boiExistente != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Editar Boi" : "Cadastro de Boi")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _nomeController,
              rotulo: "Nome",
              dica: "Digite o nome do boi",
            ),
            Editor(
              controlador: _pesoController,
              rotulo: "Peso (kg)",
              dica: "Ex: 350.5",
              icone: Icons.monitor_weight,
              tipo: TextInputType.number,
            ),
            Editor(
              controlador: _brincoController,
              rotulo: "Número do Brinco",
              dica: "Ex: 1234",
              icone: Icons.tag,
              tipo: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text(isEdit ? "Salvar Alterações" : "Cadastrar"),
              onPressed: _salvarBoi,
            ),
          ],
        ),
      ),
    );
  }
}
