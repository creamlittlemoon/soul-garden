import 'package:flutter/material.dart';

/// Soft radial gradient suggesting moon glow. Position and opacity configurable.
class MoonGlowLayer extends StatelessWidget {
  final double opacity;
  final double topOffset;
  final double rightOffset;
  final double radiusScale;

  const MoonGlowLayer({
    super.key,
    this.opacity = 0.25,
    this.topOffset = 0.08,
    this.rightOffset = 0.15,
    this.radiusScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final radius = size.width * 0.7 * radiusScale;

    return Positioned(
      top: size.height * topOffset - radius * 0.5,
      right: size.width * rightOffset - radius * 0.5,
      width: radius,
      height: radius,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFFE8D5B7).withOpacity(opacity * 0.6),
                const Color(0xFFE8D5B7).withOpacity(opacity * 0.2),
                Colors.transparent,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
