import 'package:dionys/app/models/productVariant.dart';

class ProductDetail {
  int id;
  String name;
  String description;
  int categoryId;
  String avatarUrl;
  List<String> imageUrls;
  double? price;
  double? quantity;
  double starRate;
  int numRates;
  int quantitySold;
  List<ProductVariant> variants;
  List<ProductCombination> combinations;

  ProductDetail(
      {required this.id,
      required this.name,
      required this.description,
      required this.categoryId,
      required this.avatarUrl,
      required this.imageUrls,
      this.price,
      this.quantity,
      required this.starRate,
      required this.numRates,
      required this.quantitySold,
      required this.variants,
      required this.combinations});

  static ProductDetail fromJson(Map<String, dynamic> json) {
    var variants = (json["variants"] as List)
        .map((variant) => ProductVariant.fromJson(variant))
        .toList();
    var combinations = (json["combinations"] as List)
        .map((combination) => ProductCombination.fromJson(combination))
        .toList();

    var imageUrls =
        (json["images"] as List).map((imageUrl) => imageUrl as String).toList();

    return ProductDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        categoryId: json["categoryId"],
        avatarUrl: json["coverImage"],
        imageUrls: imageUrls,
        price: json["price"],
        quantity: json["stock"],
        starRate: json["starRate"],
        numRates: json["numRates"],
        quantitySold: json["quantitySold"],
        variants: variants,
        combinations: combinations);
  }
}

class ProductCombination {
  int id;
  int firstValueId;
  int? secondValueId;
  double price;
  int quantity;

  ProductCombination(this.id, this.firstValueId, this.secondValueId, this.price,
      this.quantity);

  static ProductCombination fromJson(Map<String, dynamic> combinationJson) {
    var firstValueId = combinationJson["firstOptionId"] != 0
        ? combinationJson["firstOptionId"]
        : null;
    var secondValueId = combinationJson["secondOptionId"] != 0
        ? combinationJson["secondOptionId"]
        : null;

    return ProductCombination(combinationJson["id"], firstValueId,
        secondValueId, combinationJson["price"], combinationJson["stock"]);
  }
}
