import 'dart:convert';

import 'package:dionys/app/config.dart';
import 'package:dionys/app/models/productDetail.dart';
import 'package:http/http.dart' as http;

final apiUrl = Config.apiUrl;
final apiEndpoint = apiUrl + "product/";

class PropertyReturnModel {
  List<ProductSelectProperty> selectProperties = [];
  List<ProductTypingProperty> typingProperties = [];

  PropertyReturnModel(this.selectProperties, this.typingProperties);
}

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

  Future<PropertyReturnModel?> getProperties(int productId) async {
    final uri =
        Uri.parse(apiEndpoint + "GetProductProps/" + productId.toString());
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final propertyModelJson = jsonDecode(response.body);
      final selectPropertiesJson = propertyModelJson["selectProperties"];
      final typingPropertiesJson = propertyModelJson["typingProperties"];

      final selectProperties =
          ProductSelectProperty.fromListJson(selectPropertiesJson);
      final typingProperties =
          ProductTypingProperty.fromListJson(typingPropertiesJson);

      return PropertyReturnModel(selectProperties, typingProperties);
    }

    return null;
  }
}
