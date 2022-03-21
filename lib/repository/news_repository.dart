import 'dart:convert';

import 'package:tugasminggu4/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:tugasminggu4/globals/api_const.dart';

class NewsRepository {
  Future<List<NewsModel>> getApiData(int page) async {
    String url =
        '${Constant.baseUrl}?domains=reuters.com,thenextweb&sortBy=${Constant.shortBy}&apiKey=${Constant.apiKey}&page=$page';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = await jsonDecode(response.body);
      List<dynamic> articles = decoded['articles'];
      List<NewsModel> listOfNewsModel =
          articles.map((data) => NewsModel.fromMap(data)).toList();
      return listOfNewsModel;
    } else {
      throw Exception();
    }
  }

  Future<Map<String, dynamic>> postForm({
    required String title,
    required String description,
    required String imageUrl,
    required String content,
    required String source,
  }) async {
    http.Response response = await http.post(
      Uri.parse(Constant.postBaseUrl + '/posts'),
      body: {
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "content": content,
        "source": source,
      },
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception();
    }
  }
}
