import 'package:dionys/app/models/decodeUser.dart';
import 'package:dionys/app/services/authService.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  String? token;
  String? userId;
  DecodeUser? decodeUser;

  bool isLoading = false;

  bool get isAuth {
    return token != null && userId != null && decodeUser != null;
  }

  Future<void> login(String email, String password) async {
    await AuthService().login(email, password);
    await setUser();
  }

  Future<void> setUser() async {
    isLoading = true;
    notifyListeners();

    final token = await AuthService().getToken();
    final currentUser = await AuthService().getCurrentUser();
    final userId = await AuthService().getUserId();

    this.token = token;
    this.userId = userId;
    decodeUser = currentUser;

    isLoading = false;
    notifyListeners();
  }
}
