class CartGroup {
  int shopId;
  String shopName;
  List<CartItem> items;

  CartGroup(this.shopId, this.shopName, this.items);

  static CartGroup fromJson(Map<String, dynamic> json) {
    return CartGroup(
        json["shopId"], json["shopName"], CartItem.fromListJson(json["items"]));
  }

  static List<CartGroup> fromListJson(List<dynamic> listJson) {
    return listJson.map((json) => fromJson(json)).toList();
  }
}

class CartItem {
  int id;
  int? productId;
  int? combinationId;
  String avatarUrl;
  String name;
  double price;
  int quantity;
  int amount;
  String? combinationName;

  bool checked = false;
  bool disabled = false;

  CartItem(this.id, this.combinationId, this.avatarUrl, this.name, this.price,
      this.quantity, this.amount, this.combinationName);

  static CartItem fromJson(Map<String, dynamic> json) {
    String? combinationName;

    if (json["variants"] != null) {
      final variants = ItemVariant.fromListJson(json["variants"]);
      combinationName = variants.map((v) => v.name + " " + v.value).join(", ");
    }

    return CartItem(
        json["id"],
        json["combinationId"],
        json["image"],
        json["name"],
        json["price"],
        json["quantity"],
        json["amount"],
        combinationName);
  }

  static List<CartItem> fromListJson(List<dynamic> listJson) {
    return listJson.map((json) => fromJson(json)).toList();
  }
}

class ItemVariant {
  String name;
  String value;

  ItemVariant(this.name, this.value);

  static ItemVariant fromJson(Map<String, dynamic> json) {
    return ItemVariant(json["name"], json["value"]);
  }

  static List<ItemVariant> fromListJson(List<dynamic> listJson) {
    return listJson.map((json) => fromJson(json)).toList();
  }
}
