import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../database/app_database.dart';
import '../../database/dao/animal_dao.dart';
import '../../database/dao/cuidado_dao.dart';

class StatusDatabaseScreen extends StatefulWidget {
  const StatusDatabaseScreen({super.key});

  @override
  State<StatusDatabaseScreen> createState() => _StatusDatabaseScreenState();
}

class _StatusDatabaseScreenState extends State<StatusDatabaseScreen> {
  final AnimalDao _animalDao = AnimalDao();
  final CuidadoDao _cuidadoDao = CuidadoDao();

  int _totalAnimais = 0;
  int _totalCuidados = 0;
  int _saudaveis = 0;
  int _emTratamento = 0;
  int _doentes = 0;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      _totalAnimais = await _animalDao.getTotalAnimais();
      _totalCuidados = await _cuidadoDao.getTotalCuidados();
      _saudaveis = await _animalDao.countByStatus('Saudável');
      _emTratamento = await _animalDao.countByStatus('Em tratamento');
      _doentes = await _animalDao.countByStatus('Doente');
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erro ao carregar dados: $e';
      });
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
              const Icon(Icons.analytics, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Text(
                'Status do Banco de Dados',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _isLoading
                ? _buildLoadingState()
                : _errorMessage.isNotEmpty
                    ? _buildErrorState()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            
                            // Card de Introdução
                            _buildIntroCard(),
                            const SizedBox(height: 16),
                            
                            // Card de Informações do Banco
                            _buildDatabaseInfoCard(),
                            const SizedBox(height: 16),
                            
                            // Card de Estatísticas
                            _buildStatisticsCard(),
                            const SizedBox(height: 16),
                            
                            // Card de Estrutura das Tabelas
                            _buildTablesCard(),
                            const SizedBox(height: 16),
                            
                            // Card de Comandos SQL
                            _buildSqlCommandsCard(),
                            const SizedBox(height: 20),
                            
                            // Botão Atualizar
                            _buildUpdateButton(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
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
            'Carregando dados do banco...',
            style: GoogleFonts.inter(
              color: const Color(0xFF666666),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Erro ao carregar dados',
            style: GoogleFonts.inter(
              color: const Color(0xFF666666),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              _errorMessage,
              style: GoogleFonts.inter(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _carregarDados,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Tentar Novamente',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.storage, color: Colors.green, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    'Status do Banco de Dados',
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
                'Visualize informações sobre o banco de dados, estatísticas do rebanho e estrutura das tabelas.',
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

  Widget _buildDatabaseInfoCard() {
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
                    'Informações do Banco',
                    style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              _buildInfoItem('Nome do Banco', AppDatabase.DB_NAME, Icons.storage),
              const SizedBox(height: 12),
              _buildInfoItem('Versão', '${AppDatabase.DB_VERSION}', Icons.code),
              const SizedBox(height: 12),
              _buildInfoItem('Tabelas', 'animais, cuidados', Icons.table_chart),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
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
                    'Estatísticas do Rebanho',
                    style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Grid de Estatísticas
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: [
                  _buildStatCard('Total de Animais', '$_totalAnimais', Icons.pets, Colors.blue),
                  _buildStatCard('Total de Cuidados', '$_totalCuidados', Icons.medical_services, Colors.orange),
                  _buildStatCard('Saudáveis', '$_saudaveis', Icons.check_circle, Colors.green),
                  _buildStatCard('Em Tratamento', '$_emTratamento', Icons.healing, Colors.orange),
                  _buildStatCard('Doentes', '$_doentes', Icons.warning, Colors.red),
                  _buildStatCard('Taxa de Saúde', '${_totalAnimais > 0 ? ((_saudaveis / _totalAnimais) * 100).toStringAsFixed(1) : '0'}%', Icons.health_and_safety, Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTablesCard() {
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
                  const Icon(Icons.table_view, color: Colors.green, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Estrutura das Tabelas',
                    style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Tabela Animais
              _buildTableSection(
                'Tabela: animais',
                [
                  'id (INTEGER PRIMARY KEY)',
                  'identificacao (TEXT UNIQUE)',
                  'raca (TEXT)',
                  'peso (REAL)',
                  'data_nascimento (TEXT)',
                  'sexo (TEXT)',
                  'status_saude (TEXT)',
                  'ultimo_cuidado (TEXT)',
                  'observacoes (TEXT)',
                ],
              ),
              const SizedBox(height: 16),
              
              // Tabela Cuidados
              _buildTableSection(
                'Tabela: cuidados',
                [
                  'id (INTEGER PRIMARY KEY)',
                  'animal_id (INTEGER FOREIGN KEY)',
                  'tipo (TEXT)',
                  'descricao (TEXT)',
                  'data_cuidado (TEXT)',
                  'proximo_cuidado (TEXT)',
                  'observacoes (TEXT)',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSqlCommandsCard() {
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
                  const Icon(Icons.code, color: Colors.green, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Comandos SQL Principais',
                    style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildSqlChip('CREATE TABLE animais'),
                  _buildSqlChip('CREATE TABLE cuidados'),
                  _buildSqlChip('INSERT INTO animais'),
                  _buildSqlChip('SELECT * FROM animais'),
                  _buildSqlChip('SELECT COUNT(*) FROM animais'),
                  _buildSqlChip('UPDATE animais SET'),
                  _buildSqlChip('DELETE FROM animais'),
                  _buildSqlChip('WHERE id = ?'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _carregarDados,
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
            const Icon(Icons.refresh, size: 20),
            const SizedBox(width: 8),
            Text(
              'Atualizar Dados',
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

  Widget _buildInfoItem(String label, String value, IconData icon) {
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.interTight(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableSection(String title, List<String> columns) {
    return Container(
      width: double.infinity,
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
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 8),
            ...columns.map((column) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                '  • $column',
                style: GoogleFonts.sourceCodePro( // Using a monospace Google Font
                  fontSize: 12,
                  color: const Color(0xFF666666),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSqlChip(String command) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Text(
        command,
        style: GoogleFonts.sourceCodePro( // Using a monospace Google Font
          fontSize: 11,
          color: Colors.blue[800],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}