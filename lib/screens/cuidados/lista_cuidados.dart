import 'package:flutter/material.dart';
import '../../database/dao/cuidado_dao.dart';

class ListaCuidadosScreen extends StatefulWidget {
  const ListaCuidadosScreen({super.key});

  @override
  State<ListaCuidadosScreen> createState() => _ListaCuidadosScreenState();
}

class _ListaCuidadosScreenState extends State<ListaCuidadosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuidados Veterinários'),
      ),
      body: const Center(
        child: Text(
          'Tela de Cuidados - Em desenvolvimento',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para formulário de cuidados
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}