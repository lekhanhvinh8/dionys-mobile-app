import 'dart:convert';

import 'package:dionys/app/models/productDetail.dart';
import 'package:http/http.dart' as http;

const apiUrl = "http://localhost:5000/api/";
const apiEndpoint = apiUrl + "product/";

class ProductDetailService {
  Future<ProductDetail> get(int id) async {
    final uri = Uri.parse(apiEndpoint + id.toString());
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var productJson = jsonDecode(response.body);
      var product = ProductDetail.fromJson(productJson);

      return product;
    }

    throw Exception("request failed");
  }
}
