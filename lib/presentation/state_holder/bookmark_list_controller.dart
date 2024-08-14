import 'package:get/get.dart';
import 'package:tanchangyadictionary/data/service/bookmark_helper.dart';

import '../../data/service/database_helper.dart';


class BookmarkListController extends GetxController {
  bool _isBookmarked = false;
  List<String> bookmarkedWords = [];

  bool get isBookmarked => _isBookmarked;


  Future<void> checkIfBookmarked(String word) async {
    try {
      _isBookmarked = await BookmarkHelper.isBookmarked(word);
      update(); // Notify listeners to update UI
    } catch (e) {
      print("Error checking bookmark status: $e");
    }
  }

  Future<void> toggleBookmark(String word) async {
    try {
      if (_isBookmarked) {
        await BookmarkHelper.removeBookmark(word);
        _isBookmarked = false;
      } else {
        await BookmarkHelper.saveBookmark(word);
        _isBookmarked = true;
      }
      print("Toggled Bookmark: $_isBookmarked for word: $word");
      update(); // Notify listeners to update UI
    } catch (e) {
      print("Error toggling bookmark: $e");
    }
  }

  Future<void> loadBookmarks() async {
    try {
      List<String> bookmarks = await BookmarkHelper.getBookmarks();
      bookmarkedWords = bookmarks;
      update();
    } catch (e) {
      print("Error loading bookmarks: $e");
    }
  }

  Future<void> removeBookmark(String word) async {
    try {
      await BookmarkHelper.removeBookmark(word);
      bookmarkedWords.remove(word);
      update();
    } catch (e) {
      print("Error removing bookmark: $e");
    }
  }

  Future<String> fetchWordDefinition(String word) async {
    try {
      // Ensure the database is initialized
      await DBHelper.initDatabase();

      // Query the database for the word definition
      final List<Map<String, dynamic>> result = await DBHelper.queryWord(word);

      if (result.isNotEmpty) {
        return result.first['difination'] ?? 'Definition not found'; // Adjust the column name as needed
      } else {
        return 'Definition not found';
      }
    } catch (e) {
      print("Error fetching word definition: $e");
      return 'Error retrieving definition';
    }
  }
}