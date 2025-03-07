import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/providers/equipment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/report.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _issuesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _status = 'Concluído';

  @override
  void dispose() {
    _descriptionController.dispose();
    _issuesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitReport(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final report = Report(
        date: _selectedDate,
        description: _descriptionController.text,
        issues:
            _issuesController.text.isNotEmpty ? _issuesController.text : null,
        status: _status!,
      );

      try {
        await Provider.of<EquipmentProvider>(
          context,
          listen: false,
        ).addReport(report);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Relatório enviado com sucesso!')),
        );
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao enviar relatório: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final equipmentProvider = Provider.of<EquipmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
        backgroundColor: const Color(0xFFF2D4AE),
      ),
      body: Stack(
        children: [
          // Fundo de partículas
          const ParticleBackground(
            backgroundColor: Color.fromARGB(255, 244, 244, 39),
          ),
          // Formulário
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Data do trabalho
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Data do Trabalho',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                            text: DateFormat(
                              'dd/MM/yyyy',
                            ).format(_selectedDate),
                          ),
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Selecione uma data'
                                      : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Descrição do serviço
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Descrição do Serviço',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      maxLines: 3,
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Insira uma descrição'
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    // Problemas encontrados (opcional)
                    TextFormField(
                      controller: _issuesController,
                      decoration: InputDecoration(
                        labelText: 'Problemas Encontrados (opcional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    // Status
                    DropdownButtonFormField<String>(
                      value: _status,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Concluído',
                          child: Text('Concluído'),
                        ),
                        DropdownMenuItem(
                          value: 'Pendente',
                          child: Text('Pendente'),
                        ),
                        DropdownMenuItem(
                          value: 'Em Andamento',
                          child: Text('Em Andamento'),
                        ),
                      ],
                      onChanged: (value) => setState(() => _status = value),
                      validator:
                          (value) =>
                              value == null ? 'Selecione um status' : null,
                    ),
                    const SizedBox(height: 24),
                    // Botão de envio
                    ElevatedButton(
                      onPressed:
                          equipmentProvider.isLoading
                              ? null
                              : () => _submitReport(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFAEBF8A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
                              : const Text(
                                'Enviar Relatório',
                                style: TextStyle(
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
          // Indicadores de loading e erro
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
