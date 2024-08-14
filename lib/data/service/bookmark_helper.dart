import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class BookmarkHelper {
  static late File _bookmarkFile;
  static Map<String, bool> _bookmarks = {};

  static Future<void> initBookmarkFile() async {
    Directory? directory = await getExternalStorageDirectory();
    String path = directory!.path;
    _bookmarkFile = File('$path/bookmarks.json');

    // Create the file if it doesn't exist
    if (!(await _bookmarkFile.exists())) {
      await _bookmarkFile.create();
      await _bookmarkFile.writeAsString(jsonEncode({}));
    } else {
      // Load existing bookmarks
      String content = await _bookmarkFile.readAsString();
      _bookmarks = Map<String, bool>.from(jsonDecode(content));
    }
  }

  static Future<void> saveBookmark(String word) async {
    _bookmarks[word] = true;
    await _bookmarkFile.writeAsString(jsonEncode(_bookmarks));
    print("Bookmark saved: $word");
  }

  static Future<void> removeBookmark(String word) async {
    _bookmarks.remove(word);
    await _bookmarkFile.writeAsString(jsonEncode(_bookmarks));
    print("Bookmark removed: $word");
  }

  static Future<bool> isBookmarked(String word) async {
    return _bookmarks.containsKey(word);
  }

  static Future<List<String>> getBookmarks() async {
    return _bookmarks.keys.toList();
  }
}
