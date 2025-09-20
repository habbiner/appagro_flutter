import 'package:flutter/material.dart';
import '../../models/boi.dart';
import 'formulario.dart';

class ListaBoi extends StatefulWidget {
  const ListaBoi({super.key});

  @override
  State<ListaBoi> createState() => _ListaBoiState();
}

class _ListaBoiState extends State<ListaBoi> {
  final List<Boi> _bois = [];
  final TextEditingController _buscaController = TextEditingController();
  bool _ordenarPorPeso = true;

  List<Boi> get _boisFiltrados {
    final filtro = _buscaController.text.toLowerCase();
    if (filtro.isEmpty) return _bois;
    return _bois.where((b) => b.nome.toLowerCase().contains(filtro)).toList();
  }

  void _ordenarLista() {
    setState(() {
      if (_ordenarPorPeso) {
        _bois.sort((a, b) => a.peso.compareTo(b.peso));
      } else {
        _bois.sort((a, b) => a.numeroBrinco.compareTo(b.numeroBrinco));
      }
    });
  }

  void _editarBoi(Boi boi) async {
    final boiEditado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormularioBoi(boiExistente: boi)),
    );

    if (boiEditado != null) {
      setState(() {});
    }
  }

  void _excluirBoi(Boi boi) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmação"),
        content: const Text("Deseja realmente excluir este boi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _bois.remove(boi);
              });
              Navigator.pop(context);
            },
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _buscaController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lista = _boisFiltrados;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Bois"),
        actions: [
          IconButton(
            icon: Icon(_ordenarPorPeso ? Icons.monitor_weight : Icons.tag),
            tooltip: _ordenarPorPeso
                ? "Ordenar por Brinco"
                : "Ordenar por Peso",
            onPressed: () {
              setState(() {
                _ordenarPorPeso = !_ordenarPorPeso;
                _ordenarLista();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _buscaController,
              decoration: const InputDecoration(
                labelText: "Buscar por nome",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: lista.isEmpty
                ? const Center(
                    child: Text("Nenhum animal cadastrado ou encontrado."),
                  )
                : ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, indice) {
                      final boi = lista[indice];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown.shade200,
                            child: const Icon(Icons.pets, color: Colors.white),
                          ),
                          title: Text(
                            boi.nome,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Peso: ${boi.pesoFormatado} kg\nBrinco: ${boi.numeroBrinco}\nCadastro: ${boi.dataFormatada}",
                          ),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _editarBoi(boi),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _excluirBoi(boi),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final boiRecebido = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormularioBoi()),
          );

          if (boiRecebido != null) {
            setState(() {
              _bois.add(boiRecebido);
              _ordenarLista();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
