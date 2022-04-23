class ProductCard {
  final int id;
  final String name;
  String avatarUrl;
  final double starRate;
  final int quantitySold;
  final double price;
  final String shopAddressProvince;

  ProductCard({
    required this.id,
    required this.name,
    required this.starRate,
    required this.quantitySold,
    required this.price,
    required this.shopAddressProvince,
    required this.avatarUrl,
  });

  factory ProductCard.fromJson(Map<String, dynamic> json) {
    return ProductCard(
        id: json['id'],
        name: json['name'],
        starRate: json['starRate'],
        quantitySold: json['quantitySold'],
        price: json['price'],
        shopAddressProvince: json['province'],
        avatarUrl: json['coverImage']);
  }

  static List<ProductCard> fromListJson(List<dynamic> productCardsJson) {
    List<ProductCard> productCards = [];
    for (var productCardJson in productCardsJson) {
      var productCard = ProductCard.fromJson(productCardJson);
      productCards.add(productCard);
    }

    return productCards;
  }
}
