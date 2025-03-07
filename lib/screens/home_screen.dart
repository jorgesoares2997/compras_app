import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/models/equipments.dart';
import 'package:compras_app/screens/add_equipment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../providers/equipment_provider.dart';
import '../widgets/equipment_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EquipmentProvider>(context, listen: false).fetchEquipments();
    });
  }

  void _handleEdit(Equipment equipment) {
    print('Editar equipamento: ${equipment.id}');
  }

  void _handleDelete(Equipment equipment) {
    print('Deletar equipamento: ${equipment.id}');
  }

  @override
  Widget build(BuildContext context) {
    final equipmentProvider = Provider.of<EquipmentProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          const ParticleBackground(backgroundColor: Color(0xFF72A66A)),
          Column(
            children: [
              AppBar(
                title: const Text('Gerenciar itens'),
                backgroundColor: const Color(0xFFF2D4AE),
              ),
              Expanded(
                child:
                    equipmentProvider.equipments.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : CarouselSlider(
                          options: CarouselOptions(
                            height: 350.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.85,
                            aspectRatio: 16 / 9,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                          ),
                          items:
                              equipmentProvider.equipments.map((equipment) {
                                return EquipmentCard(
                                  equipment: equipment,
                                  onEdit: () => _handleEdit(equipment),
                                  onDelete: () => _handleDelete(equipment),
                                );
                              }).toList(),
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
