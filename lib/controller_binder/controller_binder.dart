import 'package:get/get.dart';
import 'package:tanchangyadictionary/presentation/state_holder/bookmark_list_controller.dart';
import 'package:tanchangyadictionary/presentation/state_holder/word_list_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(WordListController());
    Get.put(BookmarkListController());

  }
}
