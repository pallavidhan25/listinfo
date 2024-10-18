import 'dart:convert';
import 'package:app/database/db_helper.dart';
import 'package:app/providers/post_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../utils/constants.dart';

class ApiService {
  static Future<void> getPosts(BuildContext context) async {
    final response = await http.get(Uri.parse(API_URL));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<PostModel> dataList =
          jsonData.map((data) => PostModel.fromJson(data)).toList();

      final dbHelper = DBHelper();
      for (var post in dataList) {
        await dbHelper.insertPost(post);
      }
      Provider.of<PostProvider>(context, listen: false).setData(dataList);
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
