import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'screens/animais/lista_animais.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa o banco FAKE (funciona instantaneamente)
  await AppDatabase.initialize();
  
  runApp(const CuidadoPecuarioApp());
}

class CuidadoPecuarioApp extends StatelessWidget {
  const CuidadoPecuarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuidado Pecuário',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green,
          secondary: Colors.brown[400]!,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const ListaAnimaisScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}