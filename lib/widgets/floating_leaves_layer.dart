import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Subtle floating leaves or petals that drift down. Density and style vary by growth stage.
class FloatingLeavesLayer extends StatefulWidget {
  final String stage;

  const FloatingLeavesLayer({super.key, required this.stage});

  @override
  State<FloatingLeavesLayer> createState() => _FloatingLeavesLayerState();
}

class _FloatingLeavesLayerState extends State<FloatingLeavesLayer>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  int _countForStage(String stage) {
    switch (stage) {
      case 'seed':
      case 'sprout':
        return 0;
      case 'young_tree':
        return 3;
      case 'bloom':
        return 6;
      case 'forest':
      default:
        return 8;
    }
  }

  bool _usePetals(String stage) => stage == 'bloom';

  @override
  void initState() {
    super.initState();
    final n = _countForStage(widget.stage);
    _controllers = List.generate(
      n,
      (i) => AnimationController(
        duration: Duration(seconds: 14 + i * 2),
        vsync: this,
      ),
    );
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 400), () {
        if (!mounted) return;
        _controllers[i].repeat();
      });
    }
  }

  @override
  void didUpdateWidget(FloatingLeavesLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stage != widget.stage) {
      final newCount = _countForStage(widget.stage);
      for (final c in _controllers) c.dispose();
      _controllers = List.generate(
        newCount,
        (i) => AnimationController(
          duration: Duration(seconds: 14 + i * 2),
          vsync: this,
        ),
      );
      for (var i = 0; i < _controllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 400), () {
          if (!mounted) return;
          _controllers[i].repeat();
        });
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = _countForStage(widget.stage);
    if (n == 0) return const SizedBox.shrink();

    final usePetals = _usePetals(widget.stage);
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: List.generate(
            n,
            (i) => _FloatingLeaf(
              controller: _controllers[i],
              index: i,
              total: n,
              isPetal: usePetals,
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingLeaf extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final int total;
  final bool isPetal;

  const _FloatingLeaf({
    required this.controller,
    required this.index,
    required this.total,
    required this.isPetal,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final random = math.Random(index);
    final x = 0.15 + (random.nextDouble() * 0.7);
    final startY = -0.05 - (index * 0.08);
    final endY = 1.15;
    final swing = 0.03 * (index.isOdd ? 1 : -1);
    final baseHue = isPetal ? 0.92 : 0.35; // pink tint vs green
    final color = HSLColor.fromAHSL(
      1,
      baseHue * 360,
      0.4,
      0.75,
    ).toColor();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final t = controller.value;
        final y = startY + (endY - startY) * t;
        final sway = math.sin(t * math.pi * 4) * swing;
        final xPos = (x + sway) * size.width;
        final yPos = y * size.height;
        final opacity = (0.08 + 0.06 * (1 - (y - 0.5).abs() * 2)).clamp(0.05, 0.18);
        final scale = 0.5 + (index % 3) * 0.25;
        final rotation = t * math.pi * 2 + index * 0.5;

        return Positioned(
          left: xPos - 12,
          top: yPos - 12,
          child: Transform.rotate(
            angle: rotation,
            child: Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: CustomPaint(
                  size: const Size(24, 24),
                  painter: _LeafPainter(color: color, isPetal: isPetal),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LeafPainter extends CustomPainter {
  final Color color;
  final bool isPetal;

  _LeafPainter({required this.color, required this.isPetal});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    if (isPetal) {
      final path = Path()
        ..moveTo(center.dx, center.dy - 8)
        ..quadraticBezierTo(center.dx + 10, center.dy, center.dx + 4, center.dy + 8)
        ..quadraticBezierTo(center.dx, center.dy + 4, center.dx, center.dy)
        ..quadraticBezierTo(center.dx, center.dy + 4, center.dx - 4, center.dy + 8)
        ..quadraticBezierTo(center.dx - 10, center.dy, center.dx, center.dy - 8);
      canvas.drawPath(path, paint);
    } else {
      final path = Path()
        ..moveTo(center.dx - 10, center.dy)
        ..quadraticBezierTo(center.dx + 2, center.dy - 12, center.dx + 10, center.dy)
        ..quadraticBezierTo(center.dx + 2, center.dy + 12, center.dx - 10, center.dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
