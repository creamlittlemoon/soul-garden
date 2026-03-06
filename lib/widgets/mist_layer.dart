import 'package:flutter/material.dart';

/// Soft bottom mist/fog overlay. Opacity and height can vary by growth stage.
class MistLayer extends StatelessWidget {
  final double opacity;
  final double heightFraction;

  const MistLayer({
    super.key,
    this.opacity = 0.35,
    this.heightFraction = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: MediaQuery.of(context).size.height * heightFraction,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF16213E).withOpacity(0.15),
                const Color(0xFF1A1A2E).withOpacity(opacity),
                const Color(0xFF16213E).withOpacity(opacity * 0.9),
              ],
              stops: const [0.0, 0.35, 0.7, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
