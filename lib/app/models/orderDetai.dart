class OrderDetail {
  String id;
  int customerId;
  String customerEmail;
  String customerPhoneNumber;
  String? customerAvatar;
  int shopId;
  String shopName;
  String shopPhoneNumber;
  String? shopAvatar;
  String orderDate;
  String confirmedAt;
  String preparedAt;
  String pickupAppointment;
  String pickupedAt;
  String shippedAt;
  String cancelledAt;
  String completedAt;
  String failedAt;
  String? paymentDate;
  bool isPaid;
  int total;
  int shipFee;
  String deliveryAddress;
  String pickupAddress;
  String paymentType;
  String? paypalID;
  String status;
  bool isRated;
  List<OrderItem> items;

  OrderDetail(
    this.id,
    this.customerId,
    this.customerEmail,
    this.customerPhoneNumber,
    this.customerAvatar,
    this.shopId,
    this.shopName,
    this.shopPhoneNumber,
    this.shopAvatar,
    this.orderDate,
    this.confirmedAt,
    this.preparedAt,
    this.pickupAppointment,
    this.pickupedAt,
    this.shippedAt,
    this.cancelledAt,
    this.completedAt,
    this.failedAt,
    this.paymentDate,
    this.isPaid,
    this.total,
    this.shipFee,
    this.deliveryAddress,
    this.pickupAddress,
    this.paymentType,
    this.paypalID,
    this.status,
    this.isRated,
    this.items,
  );

  static OrderDetail fromJson(Map<String, dynamic> json) {
    final items =
        (json["items"] as List).map((e) => OrderItem.fromJson(e)).toList();
    final orderDetail = OrderDetail(
      json["id"],
      json["customerId"],
      json["customerEmail"],
      json["customerPhoneNumber"],
      json["customerAvatar"],
      json["shopId"],
      json["shopName"],
      json["shopPhoneNumber"],
      json["shopAvatar"],
      json["orderDate"],
      json["confirmedAt"],
      json["preparedAt"],
      json["pickupAppointment"],
      json["pickupedAt"],
      json["shippedAt"],
      json["cancelledAt"],
      json["completedAt"],
      json["failedAt"],
      json["paymentDate"],
      json["isPaid"],
      json["total"],
      json["shipFee"],
      json["deliveryAddress"],
      json["pickupAddress"],
      json["paymentType"],
      json["paypalID"],
      json["status"],
      json["isRated"],
      items,
    );
    return orderDetail;
  }
}

class OrderItem {
  int id;
  int productId;
  int? combinationId;
  int amount;
  int price;
  String name;
  String image;
  String variant;

  OrderItem(
    this.id,
    this.productId,
    this.combinationId,
    this.amount,
    this.price,
    this.name,
    this.image,
    this.variant,
  );

  static OrderItem fromJson(Map<String, dynamic> json) {
    return OrderItem(
        json["id"],
        json["productId"],
        json["combinationId"],
        json["amount"],
        json["price"],
        json["name"],
        json["image"],
        json["variant"]);
  }
}
