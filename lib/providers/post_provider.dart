import 'package:app/database/db_helper.dart';
import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostProvider extends ChangeNotifier {
  List<PostModel> _fetchList = [];

  List<PostModel> get fetchList => _fetchList;

  void setData(List<PostModel> dataList) {
    _fetchList = dataList;
    print(fetchList);
    notifyListeners();
  }

  Future<void> fetchPostsFromDB() async {
    final dbHelper = DBHelper();
    List<PostModel> posts = await dbHelper.getPosts();
    setData(posts);
  }
}
