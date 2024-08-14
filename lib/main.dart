import 'package:flutter/material.dart';
import 'app.dart';
import 'data/service/bookmark_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await BookmarkHelper.initBookmarkFile();
  runApp(const TcgDictionaryApp());
}
