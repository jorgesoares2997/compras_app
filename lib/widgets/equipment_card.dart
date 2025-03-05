import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/equipments.dart';

class EquipmentCard extends StatelessWidget {
  final Equipment equipment;
  final VoidCallback? onEdit; // Callback para editar
  final VoidCallback? onDelete; // Callback para deletar

  const EquipmentCard({
    required this.equipment,
    this.onEdit,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  Future<void> _launchUrl(String? url) async {
    if (url == null) return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  Color _getUrgencyColor(String? urgency) {
    switch (urgency?.toLowerCase()) {
      case 'high':
        return Colors.red[500]!;
      case 'medium':
        return Colors.orange[500]!;
      case 'low':
        return Colors.green[500]!;
      default:
        return Colors.grey[400]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 330,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2D4AE),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagem
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12.0),
            ),
            child:
                equipment.image != null
                    ? Image.network(
                      equipment.image!,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 80),
                    )
                    : const Icon(Icons.image_not_supported, size: 80),
          ),
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        equipment.title ?? 'Sem título',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (equipment.urgency != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _getUrgencyColor(equipment.urgency),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  equipment.subtitle ?? 'Sem descrição',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]!),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (equipment.mostUrgent == true) ...[
                  const SizedBox(height: 8.0),
                  const Text(
                    'Mais Urgente',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Spacer(),
          // Botões e Preço/Link
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botões de Editar e Deletar
                Row(
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit, size: 18),
                      color: Colors.black,
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFAEBF8A),
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete, size: 18),
                      color: Colors.black,
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFAEBF8A),
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                  ],
                ),
                // Preço e Link
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFAEBF8A),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        'R\$ ${equipment.price?.toStringAsFixed(2) ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFAEBF8A),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: InkWell(
                        onTap: () => _launchUrl(equipment.link),
                        child: const Text(
                          'Link',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
