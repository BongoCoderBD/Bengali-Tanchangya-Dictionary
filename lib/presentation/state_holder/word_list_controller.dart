import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../data/service/database_helper.dart';

class WordListController extends GetxController {
  List<Map<String, dynamic>> _wordList = [];
  List<Map<String, dynamic>> filteredWordList = <Map<String, dynamic>>[];

  List<Map<String, dynamic>> get wordList => _wordList;

  // Load words from the database
  Future<void> loadWords() async {
    if (kDebugMode) {
      print("Loading words...");
    }
    try {
      List<Map<String, dynamic>> words = await DBHelper.getAllWords();
      _wordList = words;
      filteredWordList.assignAll(_wordList);
      update(); // Triggers GetBuilder rebuild
      if (kDebugMode) {
        print("Words loaded: ${_wordList.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading words: $e");
      }
    }
  }

  // Filter words based on the search query
  void filterWords(String query) {
    if (query.isEmpty) {
      filteredWordList.assignAll(_wordList);
    } else {
      filteredWordList.assignAll(_wordList.where((word) {
        final wordText = word['word']?.toLowerCase() ?? '';
        return wordText.contains(query.toLowerCase());
      }).toList());
    }
    update(); // Update the UI when the filtered list changes
  }
}
