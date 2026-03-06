import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'saved_quotes_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          child: CustomScrollView(
            slivers: [
              // 顶部导航
              SliverToBoxAdapter(
                child: _buildTopBar(context),
              ),
              
              // 气味身份卡片
              SliverToBoxAdapter(
                child: _buildScentIdentityCard(userProvider),
              ),
              
              // 属性趋势
              SliverToBoxAdapter(
                child: _buildAttributesSection(userProvider),
              ),
              
              // 收藏入口
              SliverToBoxAdapter(
                child: _buildFavoritesSection(userProvider),
              ),
              
              const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
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
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFE8D5B7),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFF5F5F5),
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildScentIdentityCard(UserProvider userProvider) {
    final scentName = userProvider.getScentIdentity();
    final List<MapEntry<String, int>> topScents = userProvider.scentScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final displayScents = topScents.take(3).toList();
    
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFE8D5B7).withOpacity(0.15),
              const Color(0xFF9B8FD4).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFE8D5B7).withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Your Scent Identity',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF9B8FD4),
                letterSpacing: 2,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              scentName,
              style: const TextStyle(
                fontSize: 28,
                color: Color(0xFFE8D5B7),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            if (displayScents.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: displayScents
                        .map((e) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0xFFE8D5B7)
                                    .withOpacity(0.15),
                                border: Border.all(
                                  color: const Color(0xFFE8D5B7)
                                      .withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                e.key,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFE8D5B7),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                displayScents
                    .map((e) => '${e.key}: ${e.value}')
                    .join('   '),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: const Color(0xFFF5F5F5).withOpacity(0.7),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              _buildScentDescription(scentName),
              style: TextStyle(
                fontSize: 13,
                color: const Color(0xFFF5F5F5).withOpacity(0.6),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAttributesSection(UserProvider userProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'Attributes',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFF5F5F5),
                letterSpacing: 1,
              ),
            ),
          ),
          _buildAttributeRow('Calm', userProvider.attributes['calm'] ?? 0, const Color(0xFF7DD3C0)),
          const SizedBox(height: 12),
          _buildAttributeRow('Courage', userProvider.attributes['courage'] ?? 0, const Color(0xFFF4A261)),
          const SizedBox(height: 12),
          _buildAttributeRow('Clarity', userProvider.attributes['clarity'] ?? 0, const Color(0xFF9B8FD4)),
        ],
      ),
    );
  }
  
  Widget _buildAttributeRow(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFF5F5F5),
              ),
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFavoritesSection(UserProvider userProvider) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SavedQuotesScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF9B8FD4).withOpacity(0.1),
              border: Border.all(
                color: const Color(0xFF9B8FD4).withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bookmark,
                  color: Color(0xFF9B8FD4),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Saved Quotes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFF5F5F5),
                    ),
                  ),
                ),
                Text(
                  '${userProvider.favorites.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9B8FD4),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF9B8FD4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _buildScentDescription(String scentName) {
    switch (scentName) {
      case 'Forest Rain':
        return 'Grounded, rain-soaked calm that lingers quietly around you.';
      case 'Quiet Amber':
        return 'Warm, introspective light that glows softly at the edges.';
      case 'Moonlit Linen':
        return 'Clean, tender clarity, like sheets drying under moonlight.';
      case 'Garden Whisper':
        return 'Soft, floral curiosity that leans toward small joys.';
      case 'Sea Mist':
        return 'Open horizons, salt-bright courage, and easy breath.';
      case 'Temple Shadows':
        return 'Incense-thick reflection, a mind that loves depth.';
      case 'Mystery Seed':
        return 'Your scent story is still a seed, waiting to be watered.';
      default:
        return 'A unique blend of your inner journey, still unfolding.';
    }
  }
}
