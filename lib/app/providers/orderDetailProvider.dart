import 'package:dionys/app/models/orderDetai.dart';
import 'package:dionys/app/services/orderService.dart';
import 'package:flutter/cupertino.dart';

class RatingItem {
  int itemId;
  int stars;
  String content;
  String productName;
  String productImageUrl;

  RatingItem(this.itemId, this.stars, this.content, this.productName,
      this.productImageUrl);
}

class OrderDetailProvider with ChangeNotifier {
  OrderDetail? orderDetail;

  Future<void> reloadOrderDetail(String orderId, String token) async {
    final orderDetail = await OrderService(token).getOrderDetai(orderId);

    List<RatingItem> ratingItems = [];
    for (var item in orderDetail.items) {
      RatingItem ratingItem = RatingItem(
        item.id,
        5,
        "",
        item.name,
        item.image,
      );

      ratingItems.add(ratingItem);
    }

    this.orderDetail = orderDetail;
    ratingItems = ratingItems;

    notifyListeners();
  }
}
