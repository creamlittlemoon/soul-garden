import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _userId = '';
  int _xp = 0;
  int _level = 1;
  Map<String, int> _attributes = {
    'calm': 0,
    'courage': 0,
    'clarity': 0,
  };
  Map<String, int> _scentScores = {};
  List<String> _favorites = [];
  bool _isFirstOpen = true;
  DateTime? _lastVisit;
  
  // Getters
  String get userId => _userId;
  int get xp => _xp;
  int get level => _level;
  Map<String, int> get attributes => _attributes;
  Map<String, int> get scentScores => _scentScores;
  List<String> get favorites => _favorites;
  bool get isFirstOpen => _isFirstOpen;
  
  String get treeStage {
    if (_xp < 50) return 'seed';
    if (_xp < 200) return 'sprout';
    if (_xp < 500) return 'young_tree';
    if (_xp < 1000) return 'bloom';
    return 'forest';
  }
  
  int get xpToNextLevel {
    final thresholds = [50, 200, 500, 1000];
    for (final t in thresholds) {
      if (_xp < t) return t - _xp;
    }
    return 0;
  }
  
  String getScentIdentity() {
    if (_scentScores.isEmpty) return 'Mystery Seed';
    
    final sorted = _scentScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final top3 = sorted.take(3).map((e) => e.key).toList();
    
    // 生成名称
    final names = {
      ['woody', 'earthy', 'petrichor']: 'Forest Rain',
      ['amber', 'musk', 'vanilla']: 'Quiet Amber',
      ['clean', 'cotton', 'powdery']: 'Moonlit Linen',
      ['floral', 'sweet', 'tea']: 'Garden Whisper',
      ['ocean', 'green', 'citrus']: 'Sea Mist',
      ['incense', 'smoky', 'spicy']: 'Temple Shadows',
    };
    
    for (final entry in names.entries) {
      if (top3.any((t) => entry.key.contains(t))) {
        return entry.value;
      }
    }
    
    return 'Evolving Soul';
  }
  
  void addXp(int amount) {
    _xp += amount;
    notifyListeners();
  }
  
  void addAttribute(String attribute) {
    _attributes[attribute] = (_attributes[attribute] ?? 0) + 1;
    notifyListeners();
  }
  
  void addScentScore(String scent, int points) {
    _scentScores[scent] = (_scentScores[scent] ?? 0) + points;
    notifyListeners();
  }
  
  void toggleFavorite(String quoteId) {
    if (_favorites.contains(quoteId)) {
      _favorites.remove(quoteId);
    } else {
      _favorites.add(quoteId);
    }
    notifyListeners();
  }
  
  void markFirstOpenComplete() {
    _isFirstOpen = false;
    notifyListeners();
  }
  
  void updateLastVisit() {
    _lastVisit = DateTime.now();
    notifyListeners();
  }
  
  bool get shouldShowDailyWhisper {
    if (_lastVisit == null) return true;
    final now = DateTime.now();
    return _lastVisit!.day != now.day || 
           _lastVisit!.month != now.month || 
           _lastVisit!.year != now.year;
  }
}
