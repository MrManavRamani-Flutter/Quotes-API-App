import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quotes_api_app/models/quotes_model.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<Quote>?> fetchedQuote() async {
    String api = "https://api.quotable.io/quotes?page=1";

    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      String data = response.body;

      Map decodedData = jsonDecode(data);

      List quotesData = decodedData['results'];

      return quotesData
          .map((e) => Quote(
                id: e['_id'],
                author: e['author'],
                content: e['content'],
                authorSlug: e['authorSlug'],
              ))
          .toList();
    }
    return null;
  }
}
