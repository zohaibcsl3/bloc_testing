import 'dart:convert';

import 'package:bloc_testing/model/post_comments_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<CommentsModel>?> fetchPost() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/comments"))
          .timeout(
            const Duration(
              seconds: 10,
            ),
          );

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        var list = List<CommentsModel>.from(
            body.map((x) => CommentsModel.fromJson(x)));
        return list;
      }
    } on Exception {
      throw Exception('');
    }
    return null;
  }
}
