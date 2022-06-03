import 'dart:convert';
import 'dart:io';

import 'package:dionys/app/config.dart';
import 'package:dionys/app/models/productCard.dart';
import 'package:http/http.dart' as http;

final apiUrl = Config.apiUrl;
final apiEndpoint = apiUrl + "productFilter/";

class ProductFilterReturn {
  List<ProductCard> products;
  int totalProducts = 0;

  ProductFilterReturn({required this.products, this.totalProducts = 0});
}

class FilterRequestParams {
  int pageNumber;
  int pageSize;
  int? categoryId;
  String? searchKey;
  int? filteredCategoryId;
  int? provinceId;
  int? fromPrice;
  int? toPrice;
  int ratedStars;

  FilterRequestParams(
      {this.pageNumber = 0,
      this.pageSize = 1,
      this.ratedStars = 1,
      this.searchKey,
      this.categoryId});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> params = {
      "pageNumber": pageNumber.toString(),
      "pageSize": pageSize.toString(),
      "ratedStars": ratedStars.toString(),
    };

    if (categoryId != null) params["categoryId"] = categoryId.toString();
    if (searchKey != null) params["searchKey"] = searchKey.toString();
    if (filteredCategoryId != null) {
      params["filteredCategoryId"] = filteredCategoryId.toString();
    }
    if (provinceId != null) params["provinceId"] = provinceId.toString();
    if (fromPrice != null) params["fromPrice"] = fromPrice.toString();
    if (toPrice != null) params["toPrice"] = toPrice.toString();

    return params;
  }
}

class ProductFilterServices {
  Future<ProductFilterReturn> filter(FilterRequestParams params) async {
    var queryParameters = params.toMap();
    final uri =
        Uri.parse(apiEndpoint).replace(queryParameters: queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Token 123',
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var products = ProductCard.fromListJson(data['products']);

      var totalProducts = data['totalProducts'];

      return ProductFilterReturn(
          products: products, totalProducts: totalProducts);
    }

    return ProductFilterReturn(products: []);
  }

  Future<List<ProductCard>> getRecommendedProducts(String token) async {
    final uri = Uri.parse(apiEndpoint + "RecommendedProducts")
        .replace(queryParameters: {
      "pageSize": "10",
      "pageNumber": "0",
    });

    final resposne = await http.get(uri, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "bearer " + token,
    });

    final json = jsonDecode(resposne.body);
    final products = ProductCard.fromListJson(json["products"]);

    return products;
  }
}
