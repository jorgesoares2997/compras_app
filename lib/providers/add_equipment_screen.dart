import 'package:compras_app/ParticleBackground.dart';
import 'package:flutter/material.dart';
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
        await Provider.of<EquipmentProvider>(
          context,
          listen: false,
        ).addEquipment(equipment);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Equipamento adicionado com sucesso!')),
        );
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao adicionar: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final equipmentProvider = Provider.of<EquipmentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Equipamento')),
      body: Stack(
        children: [
          const ParticleBackground(
            backgroundColor: Color.fromARGB(255, 174, 242, 231),
          ), // Cor diferente

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Insira um título'
                                  : null,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _subtitleController,
                      decoration: const InputDecoration(
                        labelText: 'Subtítulo',
                        border: OutlineInputBorder(),
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Insira um subtítulo'
                                  : null,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Preço (R\$)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Insira um preço';
                        if (double.tryParse(value) == null)
                          return 'Insira um valor válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _imageController,
                      decoration: const InputDecoration(
                        labelText: 'URL da Imagem (opcional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _linkController,
                      decoration: const InputDecoration(
                        labelText: 'Link (opcional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _urgency,
                      decoration: const InputDecoration(
                        labelText: 'Urgência',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'high', child: Text('Alta')),
                        DropdownMenuItem(value: 'medium', child: Text('Média')),
                        DropdownMenuItem(value: 'low', child: Text('Baixa')),
                      ],
                      onChanged: (value) => setState(() => _urgency = value),
                      validator:
                          (value) =>
                              value == null ? 'Selecione a urgência' : null,
                    ),
                    const SizedBox(height: 16.0),
                    CheckboxListTile(
                      title: const Text('Mais Urgente'),
                      value: _mostUrgent,
                      onChanged:
                          (value) =>
                              setState(() => _mostUrgent = value ?? false),
                      activeColor: Colors.red,
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
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child:
                          equipmentProvider.isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                              : const Text(
                                'Adicionar Equipamento',
                                style: TextStyle(color: Colors.black),
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
