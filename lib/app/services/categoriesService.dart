import 'package:dionys/app/config.dart';
import 'package:http/http.dart' as http;

final apiUrl = Config.apiUrl;
final apiEndpoint = apiUrl + "category";

class CategoriesServices {
  Future<http.Response> get() async {
    var uri = Uri.parse(apiEndpoint);
    var result = await http.get(uri);
    return result;
  }
}
