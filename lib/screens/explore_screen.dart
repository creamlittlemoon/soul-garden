import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/garden_provider.dart';
import '../providers/user_provider.dart';
import 'garden_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gardenProvider = Provider.of<GardenProvider>(context);
    final hasCompletedLoop = gardenProvider.hasCompletedLoop;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 顶部导航
              _buildTopBar(context),
              
              const SizedBox(height: 24),
              
              // Quote 卡片或完成状态
              Expanded(
                child: hasCompletedLoop
                    ? _buildCompletionState(context)
                    : _buildQuoteCard(context),
              ),
              
              // 操作按钮（完成状态下不显示）
              if (!hasCompletedLoop) _buildActionButtons(context),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFE8D5B7),
            ),
          ),
          const Text(
            'Explore',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFF5F5F5),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
  
  Widget _buildCompletionState(BuildContext context) {
    final gardenProvider = Provider.of<GardenProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF9B8FD4).withOpacity(0.15),
              const Color(0xFF7B68EE).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFF9B8FD4).withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Today’s exploration feels complete',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFFF5F5F5),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Let your garden breathe. You can always return to wander again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: const Color(0xFFF5F5F5).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFFE8D5B7).withOpacity(0.4),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFE8D5B7).withOpacity(0.25),
                      const Color(0xFF9B8FD4).withOpacity(0.2),
                    ],
                  ),
                ),
                child: const Text(
                  'Return to Garden',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFFF5F5F5),
                    letterSpacing: 1.5,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                gardenProvider.resetSession();
              },
              child: Text(
                'Continue exploring',
                style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF9B8FD4).withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuoteCard(BuildContext context) {
    final gardenProvider = Provider.of<GardenProvider>(context);
    final quote = gardenProvider.currentQuote;
    final isFlipped = gardenProvider.isFlipped;

    final hasCalm = quote.attributes.contains('calm');
    final hasCourage = quote.attributes.contains('courage');
    final hasClarity = quote.attributes.contains('clarity');

    Color baseStart = const Color(0xFF9B8FD4);
    Color baseEnd = const Color(0xFF7B68EE);
    Color tint;
    if (hasCalm) {
      tint = const Color(0xFF7DD3C0);
    } else if (hasCourage) {
      tint = const Color(0xFFF4A261);
    } else if (hasClarity) {
      tint = const Color(0xFF9B8FD4);
    } else {
      tint = const Color(0xFF9B8FD4);
    }

    final startColor = Color.lerp(baseStart, tint, 0.3)!.withOpacity(0.18);
    final endColor = Color.lerp(baseEnd, tint, 0.2)!.withOpacity(0.12);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          gardenProvider.flipCard();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(isFlipped ? 3.14159 : 0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  startColor,
                  endColor,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF9B8FD4).withOpacity(0.2),
                width: 1,
              ),
              boxShadow: isFlipped
                  ? [
                      BoxShadow(
                        color: const Color(0xFF9B8FD4).withOpacity(0.4),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: const Color(0xFF9B8FD4).withOpacity(0.15),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
            ),
            child: isFlipped
                ? _buildBackContent(quote)
                : _buildFrontContent(quote),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFrontContent(dynamic quote) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        if (quote.isOriginal) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFFE8D5B7).withOpacity(0.16),
                border: Border.all(
                  color: const Color(0xFFE8D5B7).withOpacity(0.4),
                ),
              ),
              child: const Text(
                'Original',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 1.2,
                  color: Color(0xFFE8D5B7),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        // Mood label
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFF9B8FD4).withOpacity(0.12),
              border: Border.all(
                color: const Color(0xFF9B8FD4).withOpacity(0.35),
              ),
            ),
            child: Text(
              quote.mood,
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 1.2,
                color: const Color(0xFFE8D5B7).withOpacity(0.85),
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '"${quote.text}"',
          style: const TextStyle(
            fontSize: 22,
            height: 1.6,
            color: Color(0xFFF5F5F5),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(
          '— ${quote.source}',
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFFE8D5B7).withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          quote.interpretation,
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: const Color(0xFFF5F5F5).withOpacity(0.72),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          _buildWhyResonates(quote),
          style: TextStyle(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: const Color(0xFFE8D5B7).withOpacity(0.55),
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Text(
          'Tap to see attributes & scents',
          style: TextStyle(
            fontSize: 12,
            color: const Color(0xFF9B8FD4).withOpacity(0.6),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  String _buildWhyResonates(dynamic quote) {
    final attrPart = quote.attributes
        .map((a) => a.isEmpty ? a : '${a[0].toUpperCase()}${a.substring(1)}')
        .join(', ');
    final scentPart = quote.scents.take(3).join(', ');
    if (attrPart.isEmpty && scentPart.isEmpty) return '';
    if (attrPart.isEmpty) return 'Why it resonates · $scentPart';
    if (scentPart.isEmpty) return 'Why it resonates · $attrPart';
    return 'Why it resonates · $attrPart · $scentPart';
  }
  
  Widget _buildBackContent(dynamic quote) {
    return Transform(
      transform: Matrix4.identity()..rotateY(3.14159),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attributes',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF9B8FD4),
              letterSpacing: 2,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: quote.attributes.map((attr) => _buildTag(attr, true)).toList(),
          ),
          const SizedBox(height: 12),
          if (quote.attributes.isNotEmpty)
            Text(
              _buildAttributeImpactText(quote.attributes),
              style: TextStyle(
                fontSize: 11,
                color: const Color(0xFFF5F5F5).withOpacity(0.7),
                fontFamily: 'Inter',
              ),
            ),
          const SizedBox(height: 32),
          const Text(
            'Scent Notes',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF9B8FD4),
              letterSpacing: 2,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: quote.scents.map((scent) => _buildTag(scent, false)).toList(),
          ),
        ],
      ),
    );
  }

  String _buildAttributeImpactText(List<String> attributes) {
    final Map<String, int> counts = {};
    for (final attr in attributes) {
      counts[attr] = (counts[attr] ?? 0) + 1;
    }

    String titleCase(String key) {
      if (key.isEmpty) return key;
      return key[0].toUpperCase() + key.substring(1);
    }

    final parts = counts.entries
        .map((e) => '${titleCase(e.key)} +${e.value}')
        .toList();

    return parts.join(' • ');
  }
  
  Widget _buildTag(String text, bool isAttribute) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isAttribute
            ? const Color(0xFF7DD3C0).withOpacity(0.2)
            : const Color(0xFFE8D5B7).withOpacity(0.15),
        border: Border.all(
          color: isAttribute
              ? const Color(0xFF7DD3C0).withOpacity(0.3)
              : const Color(0xFFE8D5B7).withOpacity(0.3),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: isAttribute
              ? const Color(0xFF7DD3C0)
              : const Color(0xFFE8D5B7),
        ),
      ),
    );
  }
  
  Widget _buildActionButtons(BuildContext context) {
    final gardenProvider = Provider.of<GardenProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final quote = gardenProvider.currentQuote;
    final isFav = userProvider.favorites.contains(quote.id);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Skip
          _buildLabeledCircleButton(
            icon: Icons.close,
            label: 'Skip',
            subtitle: 'See another line',
            onTap: () {
              HapticFeedback.selectionClick();
              gardenProvider.nextQuote();
              gardenProvider.resetFlip();
            },
          ),
          
          // Like (+XP)
          _buildLabeledCircleButton(
            icon: Icons.favorite,
            color: const Color(0xFFFF6B6B),
            size: 72,
            label: 'Like',
            subtitle: '+5 XP • grow tree',
            onTap: () {
              HapticFeedback.mediumImpact();
              userProvider.addXp(5);
              for (final attr in quote.attributes) {
                userProvider.addAttribute(attr);
              }
              for (final scent in quote.scents) {
                userProvider.addScentScore(scent, 1);
              }
              gardenProvider.nextQuote();
              gardenProvider.resetFlip();
            },
          ),
          
          // Save
          _buildLabeledCircleButton(
            icon: isFav ? Icons.bookmark : Icons.bookmark_border,
            color: const Color(0xFFE8D5B7),
            label: isFav ? 'Saved' : 'Save',
            subtitle: isFav ? 'In your garden' : '+8 XP • scent boost',
            onTap: () {
              HapticFeedback.selectionClick();
              userProvider.toggleFavorite(quote.id);
              if (!isFav) {
                userProvider.addXp(8);
                for (final scent in quote.scents) {
                  userProvider.addScentScore(scent, 2);
                }
              }
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildLabeledCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    required String label,
    required String subtitle,
    Color? color,
    double size = 56,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TapFeedbackCircle(
          onTap: onTap,
          size: size,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  (color ?? const Color(0xFF9B8FD4)).withOpacity(0.3),
                  (color ?? const Color(0xFF7B68EE)).withOpacity(0.2),
                ],
              ),
              border: Border.all(
                color: (color ?? const Color(0xFF9B8FD4)).withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: color ?? const Color(0xFFF5F5F5),
              size: size * 0.4,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFF5F5F5),
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: const Color(0xFFF5F5F5).withOpacity(0.65),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}

class _TapFeedbackCircle extends StatefulWidget {
  final VoidCallback onTap;
  final double size;
  final Widget child;

  const _TapFeedbackCircle({
    required this.onTap,
    required this.size,
    required this.child,
  });

  @override
  State<_TapFeedbackCircle> createState() => _TapFeedbackCircleState();
}

class _TapFeedbackCircleState extends State<_TapFeedbackCircle> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
