import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ParticleBackground(backgroundColor: Color(0xFFF5F5F5)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título "AudioIBP"
                const Text(
                  'AudioIBP',
                  style: TextStyle(
                    fontSize: 36, // Tamanho grande para destacar
                    fontWeight: FontWeight.bold,
                    color: Color(
                      0xFF02732A,
                    ), // Cor das partículas para combinar
                    letterSpacing: 1.5, // Espaçamento leve para estilo
                  ),
                ),
                const SizedBox(height: 20), // Espaço entre título e imagem
                // Imagem SVG ou PNG do cachorro
                SvgPicture.asset(
                  'assets/images/dog_soundboard.svg', // Ou .png, ajuste conforme seu arquivo
                  width: 300,
                  height: 300,
                  placeholderBuilder:
                      (context) => const CircularProgressIndicator(),
                ),
                const SizedBox(height: 40),
                // Botão para entrar no app
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAEBF8A),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
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
        ],
      ),
    );
  }
}
