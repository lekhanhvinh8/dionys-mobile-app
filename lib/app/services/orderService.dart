import 'dart:convert';

import 'package:dionys/app/config.dart';
import 'package:dionys/app/models/orderDetail.dart';
import 'package:dionys/app/models/orderItem.dart';
import 'package:dionys/app/providers/orderDetailProvider.dart';
import 'package:http/http.dart' as http;

final apiUrl = Config.apiUrl;
final apiEndpoint = apiUrl + "order/";

class OrderFilterResponse {
  List<OrderGroup> orders;
  int totalOrders;

  OrderFilterResponse(this.orders, this.totalOrders);
}

class OrderService {
  final String token;

  Map<String, String>? requestHeaders;

  OrderService(this.token) {
    requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "bearer " + token,
    };
  }

  Future<String?> getExpectedDeliveryTime(
      int addressIdToShip, int shopId) async {
    final uri = Uri.parse(apiEndpoint + "calculateDeliveryTime")
        .replace(queryParameters: {
      "shopId": shopId.toString(),
      "addressId": addressIdToShip.toString(),
    });
    final response = await http.get(uri, headers: requestHeaders);

    return jsonDecode(response.body) as String?;
  }

  Future<double?> getShippingCost(
      List<int> cartIds, int addressIdToShip) async {
    final uri = Uri.parse(apiEndpoint + "calculateShipFee");

    final response = await http.post(uri,
        headers: requestHeaders,
        body: json.encode({
          "cartIds": cartIds.map((id) => id.toString()).toList(),
          "addressId": addressIdToShip.toString(),
        }));

    final shippingCost = jsonDecode(response.body)[0]["fee"];
    return shippingCost as double?;
  }

  Future<String> createPaypalOrder(List<int> cartIds, int addressId) async {
    final uri = Uri.parse(apiEndpoint);

    var response = await http.post(uri,
        headers: requestHeaders,
        body: json.encode({
          "cartIds": cartIds.map((id) => id.toString()).toList(),
          "addressId": addressId.toString(),
          "paymentType": "PAYPAL",
        }));

    final jsonBody = jsonDecode(response.body);

    return jsonBody["id"];
  }

  Future<String?> capturePaypalOrder(String orderId) async {
    final uri = Uri.parse(apiEndpoint + "capturePaypalOrder/" + orderId);

    var response = await http.post(
      uri,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return jsonBody["id"];
    }

    return null;
  }

  Future<OrderFilterResponse> getFilteredOrders(
      {int pageSize = 10,
      int pageNumber = 0,
      String searchKey = "",
      String? statusCode}) async {
    Map<String, String> parameters = {
      "pageSize": pageSize.toString(),
      "pageNumber": pageNumber.toString(),
      "searchKey": searchKey,
    };

    if (statusCode != null) {
      parameters["statusCode"] = statusCode;
    }

    final uri = Uri.parse(apiEndpoint + "GetFilteredOrders")
        .replace(queryParameters: parameters);

    final response = await http.get(uri, headers: requestHeaders);
    final json = jsonDecode(response.body);

    List<OrderGroup> orderGroups = [];

    for (var orderJson in json["orders"] as List) {
      orderGroups.add(OrderGroup.fromJson(orderJson));
    }

    return OrderFilterResponse(orderGroups, json["totalOrders"]);
  }

  Future<OrderDetail> getOrderDetai(String orderId) async {
    final uri =
        Uri.parse(apiEndpoint + "GetOrderDetail").replace(queryParameters: {
      "orderId": orderId,
    });

    final response = await http.get(uri, headers: requestHeaders);
    final json = jsonDecode(response.body);

    return OrderDetail.fromJson(json);
  }

  Future<bool> rate(List<RatingItem> ratingItems) async {
    List<Map<String, String>> ratings = [];
    for (var ratingItem in ratingItems) {
      ratings.add({
        "orderItemId": ratingItem.itemId.toString(),
        "stars": ratingItem.stars.toString(),
        "content": ratingItem.content,
      });
    }

    final uri = Uri.parse(apiEndpoint + "Rating");
    final result = await http.post(uri,
        headers: requestHeaders, body: json.encode({"ratings": ratings}));

    if (result.statusCode == 200) return true;
    return false;
  }
}
