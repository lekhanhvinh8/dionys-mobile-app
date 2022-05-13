import 'dart:convert';

import 'package:dionys/app/config.dart';
import 'package:dionys/app/models/cartGroup.dart';
import 'package:http/http.dart' as http;

final apiUrl = Config.apiUrl;
final apiEndpoint = apiUrl + "cart";

class CartService {
  final String token;

  Map<String, String>? requestHeaders;

  CartService(this.token) {
    requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "bearer " + token,
    };
  }

  Future<List<CartGroup>> getCarts() async {
    final uri = Uri.parse(apiEndpoint);
    final response = await http.get(uri, headers: requestHeaders);

    List<CartGroup> cartGroups = [];

    if (response.statusCode == 200) {
      final cartGroupsJson = jsonDecode(response.body);
      cartGroups = CartGroup.fromListJson(cartGroupsJson);
    }

    return cartGroups;
  }

  Future<AddToCartResponse> addToCart(
      int? productId, int? combinationId, int amount) async {
    final uri = Uri.parse(apiEndpoint);
    final response = await http.post(uri,
        headers: requestHeaders,
        body: json.encode({
          "productId": productId,
          "combinationId": combinationId,
          "amount": amount,
        }));

    if (response.statusCode == 200) {
      final cartGroup = CartGroup.fromJson(jsonDecode(response.body));
      final addToCartResponse = AddToCartResponse(cartGroup: cartGroup);
      return addToCartResponse;
    }

    if (response.statusCode == 400) {
      final errorMessage = jsonDecode(response.body);
      final addToCartResponse = AddToCartResponse(errorMessage: errorMessage);
      return addToCartResponse;
    }

    return AddToCartResponse(errorMessage: "Thêm vào giỏ hàng thất bại");
  }
}

class AddToCartResponse {
  CartGroup? cartGroup;
  String? errorMessage;

  AddToCartResponse({this.cartGroup, this.errorMessage});
}
