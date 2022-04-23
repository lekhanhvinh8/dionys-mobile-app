class ProductVariant {
  int id;
  String name;
  List<ProductVariantOption> options = [];

  ProductVariant(this.id, this.name, this.options);

  static ProductVariant fromJson(Map<String, dynamic> json) {
    var options = (json["options"] as List)
        .map((option) => ProductVariantOption.fromJson(option))
        .toList();
    return ProductVariant(json["id"], json["name"], options);
  }
}

class ProductVariantOption {
  int id;
  String name;

  ProductVariantOption(this.id, this.name);

  static ProductVariantOption fromJson(Map<String, dynamic> json) {
    return ProductVariantOption(json["id"], json["name"]);
  }
}
