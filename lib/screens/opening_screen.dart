import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/garden_provider.dart';
import '../providers/user_provider.dart';
import 'garden_screen.dart';

class OpeningScreen extends StatelessWidget {
  const OpeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gardenProvider = Provider.of<GardenProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final quote = gardenProvider.dailyWhisper;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E),
              const Color(0xFF0F3460).withOpacity(0.5),
            ],
          ),
        ),
        child: Stack(
          children: [
            // 背景粒子效果
            _buildParticles(),
            
            // 主内容
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    
                    // 月亮/微光图标
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFE8D5B7).withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE8D5B7).withOpacity(0.2),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.nightlight_round,
                        color: Color(0xFFE8D5B7),
                        size: 40,
                      ),
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // 今日低语标签
                    Text(
                      'Today\'s Whisper',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 3,
                        color: const Color(0xFF9B8FD4).withOpacity(0.8),
                        fontFamily: 'Inter',
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      'A line to water your inner garden today',
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xFFF5F5F5).withOpacity(0.7),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Quote 文本
                    Text(
                      '"${quote.text}"',
                      style: const TextStyle(
                        fontSize: 24,
                        height: 1.6,
                        color: Color(0xFFF5F5F5),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Source
                    Text(
                      '— ${quote.source}',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFFE8D5B7).withOpacity(0.7),
                      ),
                    ),
                    
                    const Spacer(flex: 3),
                    
                    // Enter Garden 按钮
                    GestureDetector(
                      onTap: () {
                        userProvider.updateLastVisit();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const GardenScreen()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF9B8FD4).withOpacity(0.3),
                              const Color(0xFF7B68EE).withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFF9B8FD4).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'Enter Garden',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFF5F5F5),
                            letterSpacing: 2,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Save 按钮
                    TextButton(
                      onPressed: () {
                        userProvider.toggleFavorite(quote.id);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            userProvider.favorites.contains(quote.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: const Color(0xFFE8D5B7),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            userProvider.favorites.contains(quote.id)
                                ? 'Saved to your garden'
                                : 'Save for later',
                            style: TextStyle(
                              color: const Color(0xFFE8D5B7).withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildParticles() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: List.generate(
            20,
            (index) => _Particle(
              delay: index * 0.5,
              x: (index % 5) / 5,
            ),
          ),
        ),
      ),
    );
  }
}

class _Particle extends StatefulWidget {
  final double delay;
  final double x;
  
  const _Particle({required this.delay, required this.x});
  
  @override
  State<_Particle> createState() => _ParticleState();
}

class _ParticleState extends State<_Particle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
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
        final y = _controller.value;
        return Positioned(
          left: widget.x * MediaQuery.of(context).size.width,
          top: y * MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: 0.3 * (1 - y),
            child: Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFFE8D5B7),
                borderRadius: BorderRadius.circular(1.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE8D5B7).withOpacity(0.5),
                    blurRadius: 4,
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
