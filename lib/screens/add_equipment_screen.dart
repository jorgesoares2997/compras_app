import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/generated/l10n.dart';
import 'package:compras_app/models/equipments.dart';
import 'package:compras_app/providers/equipment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEquipmentScreen extends StatefulWidget {
  final Equipment? equipment; // Opcional para edição

  const AddEquipmentScreen({super.key, this.equipment});

  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;
  late TextEditingController _linkController;
  String? _urgency;
  bool _mostUrgent = false;

  @override
  void initState() {
    super.initState();
    // Preenche os campos com valores do equipamento, se for edição
    _titleController = TextEditingController(
      text: widget.equipment?.title ?? '',
    );
    _subtitleController = TextEditingController(
      text: widget.equipment?.subtitle ?? '',
    );
    _priceController = TextEditingController(
      text: widget.equipment?.price?.toString() ?? '',
    );
    _imageController = TextEditingController(
      text: widget.equipment?.image ?? '',
    );
    _linkController = TextEditingController(text: widget.equipment?.link ?? '');
    _urgency = widget.equipment?.urgency ?? 'medium'; // Valor padrão
    _mostUrgent = widget.equipment?.mostUrgent ?? false;
  }

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
    if (_formKey.currentState!.validate()) {
      final equipment = Equipment(
        id: widget.equipment?.id, // Mantém o ID para edição
        title: _titleController.text,
        subtitle:
            _subtitleController.text.isEmpty ? null : _subtitleController.text,
        price: double.parse(_priceController.text),
        image: _imageController.text.isEmpty ? null : _imageController.text,
        link: _linkController.text.isEmpty ? null : _linkController.text,
        urgency: _urgency,
        mostUrgent: _mostUrgent,
      );

      final provider = Provider.of<EquipmentProvider>(context, listen: false);

      try {
        if (widget.equipment == null) {
          // Adicionar novo equipamento
          await provider.addEquipment(equipment);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(localizations.equipmentAddedSuccess)),
          );
        } else {
          // Atualizar equipamento existente
          await provider.updateEquipment(equipment);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(localizations.equipmentUpdatedSuccess)),
          );
        }
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.equipmentAddError(e.toString())),
            backgroundColor: Colors.red,
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
        title: Text(
          widget.equipment == null
              ? localizations.addItems
              : localizations.editItem,
        ),
        backgroundColor: const Color(0xFFF2D4AE),
      ),
      body: Stack(
        children: [
          const ParticleBackground(
            backgroundColor: Color.fromARGB(255, 174, 242, 231),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              40,
              16,
              16,
            ), // Reduzi o padding superior
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
                                widget.equipment == null
                                    ? localizations.addEquipment
                                    : localizations.updateEquipment,
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
