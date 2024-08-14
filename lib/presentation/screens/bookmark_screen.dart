import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanchangyadictionary/presentation/screens/details_screen.dart';
import 'package:tanchangyadictionary/presentation/state_holder/bookmark_list_controller.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<BookmarkListController>().loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarked Words"),
      ),
      body: GetBuilder<BookmarkListController>(
        builder: (bookmarkController) {
          if (bookmarkController.bookmarkedWords.isEmpty) {
            return const Center(child: Text("No Bookmarked Words"));
          }

          return ListView.builder(
            itemCount: bookmarkController.bookmarkedWords.length,
            itemBuilder: (context, index) {
              final word = bookmarkController.bookmarkedWords[index];

              return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    word,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await bookmarkController.removeBookmark(word);
                      Get.showSnackbar(
                        GetSnackBar(
                          titleText: const Text(
                            "Removed",
                            style: TextStyle(color: Colors.white),
                          ),
                          messageText: Text(
                            "$word has been removed from your bookmarks.",
                            style: const TextStyle(color: Colors.white),
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  ),

                  onTap: () async {
                    final definition = await bookmarkController.fetchWordDefinition(word);
                    Get.to(() => DetailsScreen(word: word, definition: definition));
                  }
                ),
              );
            },
          );
        },
      ),
    );
  }
}
