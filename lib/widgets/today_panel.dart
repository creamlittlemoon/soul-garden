import 'package:flutter/material.dart';

/// Compact "Today" summary: date, scent, XP to next growth, optional daily whisper.
class TodayPanel extends StatelessWidget {
  final String scentIdentity;
  final int xpToNextLevel;
  final int favoritesCount;
  final bool showDailyWhisper;

  const TodayPanel({
    super.key,
    required this.scentIdentity,
    required this.xpToNextLevel,
    required this.favoritesCount,
    this.showDailyWhisper = false,
  });

  @override
  Widget build(BuildContext context) {
    final date = _formatDate(DateTime.now());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFE8D5B7).withOpacity(0.06),
        border: Border.all(
          color: const Color(0xFFE8D5B7).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 11,
              color: const Color(0xFFE8D5B7).withOpacity(0.7),
              fontFamily: 'Inter',
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Today’s scent · $scentIdentity',
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFFF5F5F5).withOpacity(0.85),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            xpToNextLevel > 0
                ? '$xpToNextLevel XP to next growth'
                : 'Fully grown for now',
            style: TextStyle(
              fontSize: 11,
              color: const Color(0xFFE8D5B7).withOpacity(0.6),
              fontFamily: 'Inter',
            ),
          ),
          if (showDailyWhisper) ...[
            const SizedBox(height: 8),
            Text(
              'A moment for yourself today.',
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF9B8FD4).withOpacity(0.9),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${months[d.month - 1]} ${d.day}';
  }
}
