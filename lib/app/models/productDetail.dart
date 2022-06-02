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

class ProductSelectProperty {
  int propertyId;
  String propertyName;
  List<String> values = [];

  ProductSelectProperty(this.propertyId, this.propertyName, this.values);

  static ProductSelectProperty fromJson(Map<String, dynamic> json) {
    List<String> values = [];
    for (var value in json["value"]) {
      values.add(value);
    }
    return ProductSelectProperty(json["id"], json["name"], values);
  }

  static List<ProductSelectProperty> fromListJson(List<dynamic> listJson) {
    List<ProductSelectProperty> properties = [];
    for (var json in listJson) {
      final property = fromJson(json);
      properties.add(property);
    }

    return properties;
  }
}

class ProductTypingProperty {
  int propertyId;
  String propertyName;
  String value;

  ProductTypingProperty(this.propertyId, this.propertyName, this.value);

  static ProductTypingProperty fromJson(Map<String, dynamic> json) {
    return ProductTypingProperty(json["id"], json["name"], json["value"]);
  }

  static List<ProductTypingProperty> fromListJson(List<dynamic> listJson) {
    List<ProductTypingProperty> properties = [];
    for (var json in listJson) {
      final property = fromJson(json);
      properties.add(property);
    }

    return properties;
  }
}

class ProductRating {
  int id;
  String createdAt;
  int stars;
  String content;
  int orderItemId;
  String customerEmail;
  String customerAvatarUrl;

  ProductRating(this.id, this.createdAt, this.stars, this.content,
      this.orderItemId, this.customerEmail, this.customerAvatarUrl);

  static ProductRating fromJson(Map<String, dynamic> json) {
    return ProductRating(
        json["id"],
        json["createdAt"],
        json["stars"],
        json["content"],
        json["orderItemId"],
        json["customerEmail"],
        json["customerAvatarUrl"]);
  }
}
