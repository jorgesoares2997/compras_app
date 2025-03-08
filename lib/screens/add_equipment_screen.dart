import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/generated/l10n.dart';
import 'package:compras_app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../models/equipments.dart';
import '../providers/equipment_provider.dart';

class AddEquipmentScreen extends StatefulWidget {
  const AddEquipmentScreen({Key? key}) : super(key: key);

  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final _linkController = TextEditingController();
  String? _urgency;
  bool _mostUrgent = false;

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    final notificationService = NotificationService(
      Provider.of<FlutterLocalNotificationsPlugin>(context, listen: false),
    );

    if (_formKey.currentState!.validate()) {
      final equipment = Equipment(
        title: _titleController.text,
        subtitle: _subtitleController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        image: _imageController.text.isNotEmpty ? _imageController.text : null,
        link: _linkController.text.isNotEmpty ? _linkController.text : null,
        urgency: _urgency,
        mostUrgent: _mostUrgent,
      );

      try {
        print('Adding equipment: ${equipment.title}');
        await Provider.of<EquipmentProvider>(
          context,
          listen: false,
        ).addEquipment(equipment);
        if (!mounted) return;
        print('Equipment added successfully');

        // Mostrar SnackBar antes de navegar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.equipmentAddedSuccess)),
        );

        // Notificação para equipamentos urgentes
        if (_mostUrgent || _urgency == 'high') {
          print('Showing notification for urgent equipment');
          await notificationService.showNotification(
            id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            title: localizations.addEquipment,
            body: localizations.urgentEquipmentAdded(equipment.title as Object),
          );
          print('Notification shown');
        }

        // Redirecionar para a home
        await Future.delayed(
          const Duration(milliseconds: 500),
        ); // Pequeno atraso para o SnackBar ser visível
        if (!mounted) return;
        Navigator.pushReplacementNamed(
          context,
          '/main',
        ); // Substitui a tela atual pela home
      } catch (e) {
        if (!mounted) return;
        print('Error in _submitForm: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.equipmentAddError(e.toString())),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final equipmentProvider = Provider.of<EquipmentProvider>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.addItems),
        backgroundColor: const Color(0xFFF2D4AE),
      ),
      body: Stack(
        children: [
          const ParticleBackground(
            backgroundColor: Color.fromARGB(255, 174, 242, 231),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: localizations.title,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? localizations.enterTitle
                                  : null,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _subtitleController,
                      decoration: InputDecoration(
                        labelText: localizations.subtitle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? localizations.enterSubtitle
                                  : null,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: localizations.price,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations.enterPrice;
                        }
                        if (double.tryParse(value) == null) {
                          return localizations.enterValidPrice;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _imageController,
                      decoration: InputDecoration(
                        labelText: localizations.imageUrlOptional,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _linkController,
                      decoration: InputDecoration(
                        labelText: localizations.linkOptional,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _urgency,
                      decoration: InputDecoration(
                        labelText: localizations.urgency,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'high',
                          child: Text(localizations.high),
                        ),
                        DropdownMenuItem(
                          value: 'medium',
                          child: Text(localizations.medium),
                        ),
                        DropdownMenuItem(
                          value: 'low',
                          child: Text(localizations.low),
                        ),
                      ],
                      onChanged: (value) => setState(() => _urgency = value),
                      validator:
                          (value) =>
                              value == null
                                  ? localizations.selectUrgency
                                  : null,
                    ),
                    const SizedBox(height: 16.0),
                    CheckboxListTile(
                      title: Text(localizations.mostUrgent),
                      value: _mostUrgent,
                      onChanged:
                          (value) =>
                              setState(() => _mostUrgent = value ?? false),
                      activeColor: Colors.red,
                      tileColor: Colors.white.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed:
                          equipmentProvider.isLoading
                              ? null
                              : () => _submitForm(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFAEBF8A),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child:
                          equipmentProvider.isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                              : Text(
                                localizations.addEquipment,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (equipmentProvider.isLoading)
            const Center(child: CircularProgressIndicator()),
          if (equipmentProvider.errorMessage != null)
            Center(
              child: Text(
                equipmentProvider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
