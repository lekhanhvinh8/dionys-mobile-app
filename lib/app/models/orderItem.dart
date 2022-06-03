class OrderGroup {
  String id;
  String orderStatus;
  String orderDate;
  int shopId;
  String shopName;
  double total;
  double shippingCost;
  List<OrderItem> items;

  OrderGroup(this.id, this.orderStatus, this.orderDate, this.shopId,
      this.shopName, this.total, this.shippingCost, this.items);

  static OrderGroup fromJson(Map<String, dynamic> json) {
    List<OrderItem> items = (json["items"] as List)
        .map((itemJson) => OrderItem.fromJson(itemJson))
        .toList();

    final orderGroup = OrderGroup(
      json["id"],
      json["status"],
      json["orderDate"],
      json["shopId"],
      json["shopName"],
      json["total"],
      json["shipFee"],
      items,
    );

    return orderGroup;
  }
}

class OrderItem {
  int id;
  int productId;
  int? combinationId;
  String name;
  String combinationName;
  String itemAvatarUrl;
  int amount;
  double price;

  OrderItem(this.id, this.productId, this.combinationId, this.name,
      this.combinationName, this.itemAvatarUrl, this.amount, this.price);

  static OrderItem fromJson(Map<String, dynamic> json) {
    final orderItem = OrderItem(
      json["id"],
      json["productId"],
      json["combinationId"] as int?,
      json["name"],
      json["variant"],
      json["image"],
      json["amount"],
      json["price"],
    );

    return orderItem;

    // return OrderItem(
    //   1,
    //   1,
    //   1,
    //   "name",
    //   "variant",
    //   "image",
    //   1,
    //   12321,
    // );
  }
}
