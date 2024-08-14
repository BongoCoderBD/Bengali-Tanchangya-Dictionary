import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanchangyadictionary/presentation/screens/bookmark_screen.dart';
import 'package:tanchangyadictionary/presentation/state_holder/word_list_controller.dart';
import 'package:tanchangyadictionary/presentation/utility/app_colors.dart';
import 'details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.find<WordListController>().loadWords();
    _searchController.addListener(() {
      Get.find<WordListController>().filterWords(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSearchTextField(),
          ),
          _buildWordList(),
        ],
      ),
    );
  }

  // Method or Widgets is Here
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Center(
              child: Text(
                '(B-T) Dictionary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_add),
            title: const Text('All Bookmark'),
            onTap: () {
              Get.to(const BookmarkScreen());
            },
          ),
          // Add more ListTiles for additional menu options
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Bengali - Tanchangya Dictionary",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildWordList() {
    return Expanded(
      child: GetBuilder<WordListController>(
        builder: (controller) {
          if(controller.wordList.isEmpty){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(controller.filteredWordList.isEmpty) {
            return const Center(
              child: Text("Word not found"),
            );
          }

          return ListView.builder(
            itemCount: controller.filteredWordList.length,
            itemBuilder: (context, index) {
              String word =
                  controller.filteredWordList[index]['word'] ?? 'Unknown';
              String definition = controller.filteredWordList[index]
                      ['difination'] ??
                  'No definition available'; // Corrected spelling here
              return Card(
                elevation: 2,
                child: ListTile(
                  trailing: const Icon(Icons.arrow_circle_right_outlined),
                  title: Text(
                    word,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    if (kDebugMode) {
                      print("Tapped on: $word, Definition: $definition");
                    }
                    Get.to(
                      DetailsScreen(
                        word: word,
                        definition: definition,
                      ),
                    );
                    // Clear the search text
                    _searchController.clear();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSearchTextField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        fillColor: Colors.grey.shade200,
        filled: true,
        prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
      ),
      onChanged: (value) {
        Get.find<WordListController>().filterWords(value);
      },
    );
  }

// All Dispose is Here
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
