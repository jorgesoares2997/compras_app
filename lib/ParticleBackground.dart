import 'package:flutter/material.dart';
import 'dart:math';

class ParticleBackground extends StatefulWidget {
  final Color? backgroundColor; // Novo parâmetro opcional

  const ParticleBackground({this.backgroundColor, Key? key}) : super(key: key);

  @override
  _ParticleBackgroundState createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];
  final Random random = Random();
  Offset? hoverPosition;
  late Size screenSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // ~60 FPS
    )..repeat();
    _controller.addListener(_updateParticles);

    // Inicializa partículas
    for (int i = 0; i < 160; i++) {
      particles.add(Particle(random: random, screenSize: const Size(500, 500)));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.of(context).size;
    for (var particle in particles) {
      particle.screenSize = screenSize;
      particle.position = Offset(
        random.nextDouble() * screenSize.width,
        random.nextDouble() * screenSize.height,
      );
    }
  }

  void _updateParticles() {
    for (var particle in particles) {
      particle.update(hoverPosition);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          widget.backgroundColor ??
          const Color(0xFFF5F5F5), // Cor dinâmica ou padrão
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            hoverPosition = details.localPosition;
          });
        },
        onPanEnd: (_) {
          setState(() {
            hoverPosition = null;
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: ParticlePainter(particles: particles),
        ),
      ),
    );
  }
}

class Particle {
  Offset position;
  double size;
  double dx, dy;
  final Random random;
  Size screenSize;

  Particle({required this.random, required this.screenSize})
    : position = Offset(
        random.nextDouble() * screenSize.width,
        random.nextDouble() * screenSize.height,
      ),
      size = random.nextDouble() * 4 + 1, // min: 1, max: 5
      dx = (random.nextDouble() - 0.5) * 1.2, // speed: 1.2
      dy = (random.nextDouble() - 0.5) * 1.2;

  void update(Offset? hoverPosition) {
    position += Offset(dx, dy);

    if (hoverPosition != null) {
      double distance = (position - hoverPosition).distance;
      if (distance < 150) {
        Offset direction = (position - hoverPosition) / distance;
        position += direction * (150 - distance) * 0.01;
      }
    }

    if (position.dx < 0 || position.dx > screenSize.width) dx = -dx;
    if (position.dy < 0 || position.dy > screenSize.height) dy = -dy;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()..color = const Color(0xFF02732A).withOpacity(0.5); // #02732A
    final linePaint =
        Paint()
          ..color = const Color(0xFFF2D4AE).withOpacity(0.5) // #F2D4AE
          ..strokeWidth = 1;

    for (var i = 0; i < particles.length; i++) {
      canvas.drawCircle(particles[i].position, particles[i].size, paint);
      for (var j = i + 1; j < particles.length; j++) {
        double distance =
            (particles[i].position - particles[j].position).distance;
        if (distance < 100) {
          canvas.drawLine(
            particles[i].position,
            particles[j].position,
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
