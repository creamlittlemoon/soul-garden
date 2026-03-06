import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/audio_service.dart';
import '../widgets/tree_widget.dart';
import '../widgets/attribute_bar.dart';
import '../widgets/mist_layer.dart';
import '../widgets/moon_glow_layer.dart';
import '../widgets/floating_leaves_layer.dart';
import '../widgets/today_panel.dart';
import 'explore_screen.dart';
import 'profile_screen.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  @override
  void initState() {
    super.initState();
    AudioService.startAmbient();
  }

  @override
  void dispose() {
    AudioService.stopAmbient();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E),
              const Color(0xFF1A1A2E),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Layered ambience (back to front)
              _buildMistLayer(userProvider.treeStage),
              _buildMoonGlow(userProvider.treeStage),
              _buildBackgroundParticles(userProvider.treeStage),
              FloatingLeavesLayer(stage: userProvider.treeStage),

              Column(
                children: [
                  // 顶部导航
                  _buildTopBar(context),
                  
                  const Spacer(),
                  
                  // 树苗（呼吸动效）
                  _buildTreeWithGlow(userProvider),
                  
                  const SizedBox(height: 16),
                  
                  // 成长阶段标签
                  _buildStageLabel(userProvider),
                  
                  const SizedBox(height: 32),
                  
                  // 属性条
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Column(
                      children: [
                        AttributeBar(
                          label: 'Calm',
                          value: userProvider.attributes['calm'] ?? 0,
                          color: const Color(0xFF7DD3C0),
                        ),
                        const SizedBox(height: 12),
                        AttributeBar(
                          label: 'Courage',
                          value: userProvider.attributes['courage'] ?? 0,
                          color: const Color(0xFFF4A261),
                        ),
                        const SizedBox(height: 12),
                        AttributeBar(
                          label: 'Clarity',
                          value: userProvider.attributes['clarity'] ?? 0,
                          color: const Color(0xFF9B8FD4),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Today panel
                  TodayPanel(
                    scentIdentity: userProvider.getScentIdentity(),
                    xpToNextLevel: userProvider.xpToNextLevel,
                    favoritesCount: userProvider.favorites.length,
                    showDailyWhisper: userProvider.shouldShowDailyWhisper,
                  ),
                  
                  const Spacer(),
                  
                  // Explore 按钮
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: GestureDetector(
                      onTap: () {
                        AudioService.playTap();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ExploreScreen()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF9B8FD4).withOpacity(0.4),
                              const Color(0xFF7B68EE).withOpacity(0.3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFF9B8FD4).withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.explore_outlined,
                              color: Color(0xFFF5F5F5),
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Explore',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFF5F5F5),
                                letterSpacing: 2,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTreeWithGlow(UserProvider userProvider) {
    final isNearGrowth = userProvider.xpToNextLevel > 0 && userProvider.xpToNextLevel <= 10;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: isNearGrowth
            ? [
                BoxShadow(
                  color: const Color(0xFFE8D5B7).withOpacity(0.45),
                  blurRadius: 28,
                  spreadRadius: 4,
                ),
              ]
            : [
                BoxShadow(
                  color: const Color(0xFF9B8FD4).withOpacity(0.25),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
      ),
      child: const TreeWidget(),
    );
  }

  Widget _buildStageLabel(UserProvider userProvider) {
    final stageKey = userProvider.treeStage;
    String stageName;
    String description;

    switch (stageKey) {
      case 'seed':
        stageName = 'Seed';
        description = 'A quiet beginning, held in the dark soil.';
        break;
      case 'sprout':
        stageName = 'Sprout';
        description = 'New leaves testing the air of your days.';
        break;
      case 'young_tree':
        stageName = 'Young Tree';
        description = 'Roots reaching deeper as your branches grow.';
        break;
      case 'bloom':
        stageName = 'Bloom';
        description = 'Petals open to the small joys you notice.';
        break;
      case 'forest':
      default:
        stageName = 'Forest';
        description = 'A whole grove grown from the lines you chose.';
        break;
    }

    return Column(
      children: [
        Text(
          stageName,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFE8D5B7),
            letterSpacing: 1.5,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            height: 1.5,
            color: const Color(0xFFF5F5F5).withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile 入口
          GestureDetector(
            onTap: () {
              AudioService.playTap();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF9B8FD4).withOpacity(0.1),
              ),
              child: const Icon(
                Icons.person_outline,
                color: Color(0xFFE8D5B7),
              ),
            ),
          ),
          
          // 气味身份标签
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFE8D5B7).withOpacity(0.1),
              border: Border.all(
                color: const Color(0xFFE8D5B7).withOpacity(0.3),
              ),
            ),
            child: Text(
              userProvider.getScentIdentity(),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFE8D5B7),
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMistLayer(String stage) {
    final isEarly = stage == 'seed' || stage == 'sprout';
    return MistLayer(
      opacity: isEarly ? 0.45 : 0.3,
      heightFraction: isEarly ? 0.55 : 0.45,
    );
  }

  Widget _buildMoonGlow(String stage) {
    final isLate = stage == 'bloom' || stage == 'forest';
    return MoonGlowLayer(
      opacity: isLate ? 0.32 : 0.22,
      topOffset: 0.08,
      rightOffset: 0.18,
      radiusScale: isLate ? 1.15 : 1.0,
    );
  }

  Widget _buildBackgroundParticles(String stage) {
    final count = stage == 'seed' || stage == 'sprout' ? 8 : 15;
    final isWarm = stage == 'bloom' || stage == 'forest';
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: List.generate(
            count,
            (index) => _FloatingParticle(
              delay: index * 0.8,
              x: (index % 4) / 4 + 0.1,
              warmTint: isWarm,
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingParticle extends StatefulWidget {
  final double delay;
  final double x;
  final bool warmTint;

  const _FloatingParticle({
    required this.delay,
    required this.x,
    this.warmTint = false,
  });
  
  @override
  State<_FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<_FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      _controller.repeat();
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final y = 0.3 + (t * 0.4);
        final opacity = 0.2 + (0.1 * (1 - (y - 0.5).abs() * 2));
        
        return Positioned(
          left: widget.x * MediaQuery.of(context).size.width,
          top: y * MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: widget.warmTint
                    ? const Color(0xFFE8D5B7)
                    : const Color(0xFF9B8FD4),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: (widget.warmTint
                            ? const Color(0xFFE8D5B7)
                            : const Color(0xFF9B8FD4))
                        .withOpacity(0.4),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
