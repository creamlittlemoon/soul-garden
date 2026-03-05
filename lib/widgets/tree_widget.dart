import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class TreeWidget extends StatefulWidget {
  const TreeWidget({super.key});

  @override
  State<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _breathAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    
    _breathAnimation = Tween<double>(
      begin: 0.98,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _controller.repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final stage = Provider.of<UserProvider>(context).treeStage;
    
    return AnimatedBuilder(
      animation: _breathAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _breathAnimation.value,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF9B8FD4).withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
            child: Center(
              child: _buildTreeByStage(stage),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildTreeByStage(String stage) {
    switch (stage) {
      case 'seed':
        return const _SeedIcon();
      case 'sprout':
        return const _SproutIcon();
      case 'young_tree':
        return const _YoungTreeIcon();
      case 'bloom':
        return const _BloomIcon();
      case 'forest':
        return const _ForestIcon();
      default:
        return const _SeedIcon();
    }
  }
}

class _SeedIcon extends StatelessWidget {
  const _SeedIcon();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      size: 40,
      color: const Color(0xFFE8D5B7).withOpacity(0.8),
    );
  }
}

class _SproutIcon extends StatelessWidget {
  const _SproutIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.spa,
      size: 60,
      color: Color(0xFF7DD3C0),
    );
  }
}

class _YoungTreeIcon extends StatelessWidget {
  const _YoungTreeIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.park,
      size: 80,
      color: Color(0xFF7DD3C0),
    );
  }
}

class _BloomIcon extends StatelessWidget {
  const _BloomIcon();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(
          Icons.park,
          size: 100,
          color: Color(0xFF7DD3C0),
        ),
        Positioned(
          top: 10,
          right: 30,
          child: Icon(
            Icons.local_florist,
            size: 30,
            color: const Color(0xFFFFB6C1).withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

class _ForestIcon extends StatelessWidget {
  const _ForestIcon();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(
          Icons.forest,
          size: 120,
          color: Color(0xFF7DD3C0),
        ),
        Positioned(
          top: 0,
          right: 20,
          child: Icon(
            Icons.wb_sunny,
            size: 40,
            color: const Color(0xFFE8D5B7).withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
