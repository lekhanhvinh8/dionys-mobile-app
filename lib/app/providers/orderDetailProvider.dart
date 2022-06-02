import 'package:dionys/app/models/orderDetail.dart';
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
  List<RatingItem> ratings = [];

  void updateRating(int itemId, double stars) {
    for (var rating in ratings) {
      if (rating.itemId == itemId) {
        rating.stars = stars.toInt();
        notifyListeners();
        break;
      }
    }
  }

  void updateContent(int itemId, String content) {
    for (var rating in ratings) {
      if (rating.itemId == itemId) {
        rating.content = content;
        notifyListeners();
        break;
      }
    }
  }

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
    ratings = ratingItems;

    notifyListeners();
  }
}
