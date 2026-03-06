import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/garden_provider.dart';

class SavedQuotesScreen extends StatelessWidget {
  const SavedQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final gardenProvider = Provider.of<GardenProvider>(context);

    final savedQuotes = gardenProvider.quotes
        .where((q) => userProvider.favorites.contains(q.id))
        .toList();

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
          child: Column(
            children: [
              _buildTopBar(context, savedQuotes.length),
              const SizedBox(height: 8),
              Expanded(
                child: savedQuotes.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        itemCount: savedQuotes.length,
                        itemBuilder: (context, index) {
                          final quote = savedQuotes[index];
                          return _SavedQuoteCard(quote: quote);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, int count) {
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
            'Saved Quotes',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFF5F5F5),
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF9B8FD4),
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.bookmark_border,
              color: Color(0xFF9B8FD4),
              size: 40,
            ),
            const SizedBox(height: 16),
            const Text(
              'No saved quotes yet',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFF5F5F5),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'When a line feels like it belongs to your garden, tap Save. It will rest here for you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: const Color(0xFFF5F5F5).withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedQuoteCard extends StatelessWidget {
  final dynamic quote;

  const _SavedQuoteCard({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFE8D5B7).withOpacity(0.12),
            const Color(0xFF9B8FD4).withOpacity(0.08),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFE8D5B7).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"${quote.text}"',
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Color(0xFFF5F5F5),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '— ${quote.source}',
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFFE8D5B7).withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16),
          if (quote.attributes.isNotEmpty) ...[
            Text(
              'Attributes',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 1.5,
                color: const Color(0xFF9B8FD4).withOpacity(0.9),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: quote.attributes
                  .map<Widget>((a) => _buildTag(a, true))
                  .toList(),
            ),
            const SizedBox(height: 12),
          ],
          if (quote.scents.isNotEmpty) ...[
            Text(
              'Scent Notes',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 1.5,
                color: const Color(0xFF9B8FD4).withOpacity(0.9),
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: quote.scents
                  .map<Widget>((s) => _buildTag(s, false))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTag(String text, bool isAttribute) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isAttribute
            ? const Color(0xFF7DD3C0).withOpacity(0.2)
            : const Color(0xFFE8D5B7).withOpacity(0.18),
        border: Border.all(
          color: isAttribute
              ? const Color(0xFF7DD3C0).withOpacity(0.4)
              : const Color(0xFFE8D5B7).withOpacity(0.35),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: isAttribute
              ? const Color(0xFF7DD3C0)
              : const Color(0xFFE8D5B7),
        ),
      ),
    );
  }
}

