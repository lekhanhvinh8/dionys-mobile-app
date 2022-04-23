import 'package:http/http.dart' as http;

const apiUrl = "http://localhost:5000/api/";

class CategoriesServices {
  Future<http.Response> get(String url) async {
    var uri = Uri.parse(url);
    var result = await http.get(uri);
    return result;
  }
}
