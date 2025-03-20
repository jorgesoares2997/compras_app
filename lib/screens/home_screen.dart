import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/generated/l10n.dart';
import 'package:compras_app/models/equipments.dart';
import 'package:compras_app/screens/add_equipment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../providers/equipment_provider.dart';
import '../widgets/equipment_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEquipmentScreen(equipment: equipment),
      ),
    );
  }

  void _handleAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddEquipmentScreen()),
    );
  }

  void _handleDelete(Equipment equipment) async {
    final provider = Provider.of<EquipmentProvider>(context, listen: false);
    final localizations = AppLocalizations.of(context)!;
    try {
      await provider.deleteEquipment(equipment.id!);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.deleteSuccess)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(localizations.deleteError)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final equipmentProvider = Provider.of<EquipmentProvider>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          const ParticleBackground(backgroundColor: Color(0xFF72A66A)),
          Column(
            children: [
              AppBar(
                title: Text(localizations.manageItems),
                backgroundColor: const Color(0xFFF2D4AE),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _handleAdd,
                    tooltip: localizations.addItem,
                  ),
                ],
              ),
              Expanded(
                child:
                    equipmentProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : equipmentProvider.error != null
                        ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(localizations.errorLoading),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed:
                                    () => equipmentProvider.fetchEquipments(),
                                child: Text(localizations.retry),
                              ),
                            ],
                          ),
                        )
                        : equipmentProvider.equipments.isEmpty
                        ? Center(child: Text(localizations.noItems))
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
