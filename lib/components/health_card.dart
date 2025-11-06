import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/animal.dart';
import 'package:intl/intl.dart';

class HealthCard extends StatelessWidget {
  final Animal animal;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const HealthCard({
    super.key,
    required this.animal,
    required this.onTap,
    required this.onDelete,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Saudável':
        return Colors.green;
      case 'Em tratamento':
        return Colors.orange;
      case 'Doente':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusIcon(String status) {
    switch (status) {
      case 'Saudável':
        return '😊';
      case 'Em tratamento':
        return '😐';
      case 'Doente':
        return '😔';
      default:
        return '🐄';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header com identificação e status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getStatusColor(animal.statusSaude),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              animal.identificacao,
                              style: GoogleFonts.interTight(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          animal.raca,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        _getStatusIcon(animal.statusSaude),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20),
                        onPressed: onDelete,
                        color: Colors.red,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Informações do animal
              Row(
                children: [
                  _buildInfoChip('${animal.peso} kg', Icons.monitor_weight, Colors.blue),
                  const SizedBox(width: 8),
                  _buildInfoChip(animal.sexo, Icons.female, Colors.pink),
                  const SizedBox(width: 8),
                  _buildStatusChip(animal.statusSaude),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Footer com data do último cuidado
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Último cuidado: ${DateFormat('dd/MM/yyyy').format(animal.ultimoCuidado)}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Ver detalhes',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward, size: 12, color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _getStatusColor(status),
        ),
      ),
    );
  }
}