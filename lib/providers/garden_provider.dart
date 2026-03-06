import 'package:flutter/material.dart';
import 'dart:math';

class Quote {
  final String id;
  final String text;
  final String source;
  final List<String> attributes;
  final List<String> scents;
  final bool isOriginal;
  final String interpretation;
  final String mood;

  Quote({
    required this.id,
    required this.text,
    required this.source,
    required this.attributes,
    required this.scents,
    this.isOriginal = false,
    required this.interpretation,
    required this.mood,
  });
}

class GardenProvider extends ChangeNotifier {
  final List<Quote> _quotes = [
    Quote(
      id: '1',
      text: 'The quieter you become, the more you can hear.',
      source: 'Ram Dass',
      attributes: ['clarity'],
      scents: ['woody', 'clean', 'powdery'],
      interpretation: 'Silence isn’t empty—it’s where understanding grows.',
      mood: 'Clear',
    ),
    Quote(
      id: '2',
      text: 'Your soul is a garden. Water it with presence.',
      source: 'Soul Garden Original',
      attributes: ['calm'],
      scents: ['floral', 'green', 'tea'],
      isOriginal: true,
      interpretation: 'Presence is the water; your attention, the sun.',
      mood: 'Gentle',
    ),
    Quote(
      id: '3',
      text: 'Courage is not the absence of fear, but the triumph over it.',
      source: 'Nelson Mandela',
      attributes: ['courage'],
      scents: ['amber', 'musk', 'spicy'],
      interpretation: 'Strength isn’t about never feeling fear; it’s about moving with it.',
      mood: 'Bold',
    ),
    Quote(
      id: '4',
      text: 'In the depth of winter, I finally learned that within me there lay an invincible summer.',
      source: 'Albert Camus',
      attributes: ['courage', 'clarity'],
      scents: ['woody', 'petrichor', 'citrus'],
      interpretation: 'Even in the coldest season, something in you stays alive and warm.',
      mood: 'Warm',
    ),
    Quote(
      id: '5',
      text: 'The present moment is filled with joy and happiness. If you are attentive, you will see it.',
      source: 'Thich Nhat Hanh',
      attributes: ['calm'],
      scents: ['floral', 'sweet', 'herbal'],
      interpretation: 'Joy lives in the ordinary when we slow down enough to meet it.',
      mood: 'Gentle',
    ),
    Quote(
      id: '6',
      text: 'What you seek is seeking you.',
      source: 'Rumi',
      attributes: ['clarity'],
      scents: ['incense', 'spicy', 'musk'],
      interpretation: 'You and what you long for are already moving toward each other.',
      mood: 'Clear',
    ),
    Quote(
      id: '7',
      text: 'Be like a tree and let the dead leaves drop.',
      source: 'Rumi',
      attributes: ['courage', 'calm'],
      scents: ['woody', 'earthy', 'petrichor'],
      interpretation: 'Letting go of what no longer serves you is its own kind of courage.',
      mood: 'Grounding',
    ),
    Quote(
      id: '8',
      text: 'Peace comes from within. Do not seek it without.',
      source: 'Buddha',
      attributes: ['calm', 'clarity'],
      scents: ['clean', 'powdery', 'vanilla'],
      interpretation: 'The peace you want is already here, waiting for your attention.',
      mood: 'Gentle',
    ),
  ];
  
  int _currentIndex = 0;
  bool _isFlipped = false;
  int _seenCount = 0;
  
  List<Quote> get quotes => _quotes;
  Quote get currentQuote => _quotes[_currentIndex];
  bool get isFlipped => _isFlipped;
  bool get hasCompletedLoop => _seenCount >= _quotes.length && _quotes.isNotEmpty;
  
  Quote get dailyWhisper => _quotes[DateTime.now().day % _quotes.length];
  
  void nextQuote() {
    _seenCount++;
    _currentIndex = (_currentIndex + 1) % _quotes.length;
    _isFlipped = false;
    notifyListeners();
  }
  
  void previousQuote() {
    _currentIndex = (_currentIndex - 1 + _quotes.length) % _quotes.length;
    _isFlipped = false;
    notifyListeners();
  }
  
  void flipCard() {
    _isFlipped = !_isFlipped;
    notifyListeners();
  }
  
  void resetFlip() {
    _isFlipped = false;
    notifyListeners();
  }

  void resetSession() {
    _seenCount = 0;
    notifyListeners();
  }
  
  Quote getRandomQuote() {
    return _quotes[Random().nextInt(_quotes.length)];
  }
}
