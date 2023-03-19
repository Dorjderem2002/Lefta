import 'package:flutter/material.dart';

final Map<String, String> emojiMap = {
  "Food": "🍔",
  "Transport": "🚆",
  "Groceries": "🛒",
  "Clothes": "👕",
  "Snacks": "🍦",
  "Health": "🏥",
  "Utilities": "💡",
  "Housing": "🏠",
  "Personal": "🧑🏻",
  "Entertainment": "🍿",
  "Gift": "🎁",
  "Other": "💰",
};

final List<String> categoryExpense = [
  "Food",
  "Transport",
  "Groceries",
  "Snacks",
  "Housing",
  "Utilities",
  "Clothes",
  "Health",
  "Personal",
  "Entertainment",
  "Gift",
  "Other"
];

final Map<int, double> lenMap = {
  0: 50,
  1: 50,
  2: 50,
  3: 50,
  4: 50,
  5: 50,
  6: 40,
  7: 40,
  8: 30,
  9: 30,
  10: 30
};

final Map<String, Color> colorMap = {
  "Food": const Color(0xFF64b5f6),
  "Transport" : const Color(0xFFff7043),
  "Groceries" : const Color(0xFFaed581),
  "Snacks" : const Color(0xFFf06292),
  "Housing" : const Color(0xFF4db6ac),
  "Utilities" : const Color(0xFFba68c8),
  "Clothes" : const Color(0xFFe0e0e0),
  "Health" : const Color(0xFF939B62),
  "Personal" : const Color(0xFFffb74d),
  "Entertainment" : const Color(0xFF3A4F7A),
  "Gift" : const Color(0xFF227C70),
  "Other" : const Color(0xFF90a4ae),
};