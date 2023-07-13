import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simplebloc/data/model/postmodel.dart';

class PostRepository {
  String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostsModel>> fetchPost() async {
    List<PostsModel> posts = [];

    http.Response response = await http.get(Uri.parse(baseUrl));

    try {
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body);

        posts = result
            .map((singlePost) => PostsModel.fromJson(singlePost))
            .toList();
      }
    } catch (err) {
      rethrow;
    }
    return posts;
  }

  Future<String?> updatePost(PostsModel pm) async {
    String nresponse = '';
    debugPrint(pm.runtimeType.toString());
    try {
      final response = await http.patch(
          Uri.parse('https://jsonplaceholder.typicode.com/posts/${pm.id}'),
          body: pm.toJson());

      debugPrint(response.toString());

      if (response.statusCode == 200) {
        nresponse = 'success';
      }
    } catch (err) {
      rethrow;
    }

    return nresponse;
  }
}
