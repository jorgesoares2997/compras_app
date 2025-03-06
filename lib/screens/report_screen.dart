import 'package:compras_app/ParticleBackground.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório'),
        backgroundColor: const Color(0xFFF2D4AE),
      ),
      body: const Stack(
        children: [
          ParticleBackground(backgroundColor: Color(0xFFF5F5F5)),
          Center(child: Text('Tela de Relatório (em desenvolvimento)')),
        ],
      ),
    );
  }
}
