import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_holder/bookmark_list_controller.dart';

class DetailsScreen extends StatefulWidget {
  final String word;
  final String definition;

  const DetailsScreen(
      {super.key, required this.word, required this.definition});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<BookmarkListController>().checkIfBookmarked(widget.word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word),
        actions: [_buildBookmark()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildWord(),
            buildMeaning(),
          ],
        ),
      ),
    );
  }

  // All Widgets is here
  GetBuilder<BookmarkListController> _buildBookmark() {
    return GetBuilder<BookmarkListController>(builder: (bookMarkController) {
      return IconButton(
        onPressed: () {
          if (bookMarkController.isBookmarked) {
            // If the word is already bookmarked, show the Snackbar
            Get.showSnackbar(
              const GetSnackBar(
                titleText: Text(
                  "Already Bookmarked",
                  style: TextStyle(color: Colors.white),
                ),
                messageText: Text(
                  "This word is already in your bookmarks.",
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.orange,
              ),
            );
          } else {
            // If the word is not bookmarked, allow bookmarking
            bookMarkController.toggleBookmark(widget.word);
            Get.showSnackbar(
              const GetSnackBar(
                titleText: Text(
                  "Bookmarked",
                  style: TextStyle(color: Colors.white),
                ),
                messageText: Text(
                  "The word has been added to your bookmarks.",
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        icon: Icon(
          bookMarkController.isBookmarked
              ? Icons.bookmark // Show the bookmarked icon
              : Icons.bookmark_outline, // Show the unbookmarked icon
        ),
      );
    });
  }

  Text buildMeaning() {
    return Text.rich(
      TextSpan(
          text: "Meaning: ",
          style: const TextStyle(
            fontSize: 20,
          ),
          children: [
            TextSpan(
              text: widget.definition,
              style: const TextStyle(
                fontFamily: 'TanchangyaFont',
                fontSize: 20,
              ),
            )
          ]),
    );
  }

  Text buildWord() {
    return Text.rich(
      TextSpan(
          text: "Word: ",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: widget.word,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ]),
    );
  }
}
