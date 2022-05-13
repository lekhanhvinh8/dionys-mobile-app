import 'dart:convert';
import 'package:dionys/app/config.dart';
import 'package:dionys/app/models/decodeUser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

final apiUrl = Config.apiUrl;

class AuthService {
  static String roleCustomer = "User";
  static String roleSeller = "Seller";

  final apiEndpoint = apiUrl + "User";

  final userDataKeyName = "userData";
  final jwtKeyName = "jwt";
  final userIdKeyName = "userId";

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };

  Future<String?> login(String email, String password) async {
    var uri = Uri.parse(apiEndpoint + "/Login");
    var response = await http.post(uri,
        headers: requestHeaders,
        body: json.encode({"email": email, "password": password}));

    if (response.statusCode == 200) {
      var userJson = jsonDecode(response.body);

      final userName = userJson["username"];
      final id = userJson["id"];
      final token = userJson["token"];
      final roleName = userJson["roleName"];

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          jwtKeyName: token,
          userIdKeyName: id,
        },
      );
      prefs.setString(userDataKeyName, userData);

      return token;
    }

    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userDataKeyName);
    //prefs.clear();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(userDataKeyName)) {
      return null;
    }
    final extractedUserData =
        json.decode(prefs.getString(userDataKeyName) as String)
            as Map<String, Object>;

    final token = extractedUserData[jwtKeyName] as String;
    return token;
  }

  Future<DecodeUser?> getCurrentUser() async {
    try {
      final token = await getToken();
      if (token != null) {
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        DecodeUser user = DecodeUser.fromJson(payload);
        return user;
      }
    } catch (ex) {
      return null;
    }

    return null;
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(userDataKeyName)) {
      return null;
    }
    final extractedUserData =
        json.decode(prefs.getString(userDataKeyName) as String)
            as Map<String, Object>;

    final userId = extractedUserData[userIdKeyName] as String;
    return userId;
  }
}
