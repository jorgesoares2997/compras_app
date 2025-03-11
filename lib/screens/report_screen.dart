import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/generated/l10n.dart';
import 'package:compras_app/providers/equipment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    final localizations = AppLocalizations.of(context)!;
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

        // Exibe mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.reportSubmittedSuccess),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Aguarda um pouco para o usuário ver a mensagem antes de redirecionar
        await Future.delayed(const Duration(seconds: 2));

        if (!mounted) return;

        // Redireciona para a MainScreen
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/main',
          (route) => false, // Remove todas as rotas anteriores
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${localizations.reportSubmissionError}: $e'),
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
        title: Text(localizations.reports),
        backgroundColor: const Color(0xFFF2D4AE),
      ),
      body: Stack(
        children: [
          const ParticleBackground(
            backgroundColor: Color.fromARGB(255, 244, 244, 39),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: localizations.workDate,
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
                                      ? localizations.selectDate
                                      : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: localizations.serviceDescription,
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
                                  ? localizations.enterDescription
                                  : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _issuesController,
                      decoration: InputDecoration(
                        labelText: localizations.issuesFoundOptional,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _status,
                      decoration: InputDecoration(
                        labelText: localizations.status,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Concluído',
                          child: Text(localizations.completed),
                        ),
                        DropdownMenuItem(
                          value: 'Pendente',
                          child: Text(localizations.pending),
                        ),
                        DropdownMenuItem(
                          value: 'Em Andamento',
                          child: Text(localizations.inProgress),
                        ),
                      ],
                      onChanged: (value) => setState(() => _status = value),
                      validator:
                          (value) =>
                              value == null ? localizations.selectStatus : null,
                    ),
                    const SizedBox(height: 24),
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
                              : Text(
                                localizations.submitReport,
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
