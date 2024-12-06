import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/review_model.dart';

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/comments";

  Future<List<ReviewModel>> fetchComments({int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl?_limit=$limit'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => ReviewModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}