import 'package:dionys/app/models/productDetail.dart';
import 'package:dionys/app/services/productDetailService.dart';
import 'package:flutter/material.dart';

class SelectedVariantOption {
  int variantId;
  int optionId;

  SelectedVariantOption(this.variantId, this.optionId);
}

class ProductDetailProvider with ChangeNotifier {
  ProductDetail? productDetail;
  List<SelectedVariantOption> selectedVariantOptions = [];
  double? productPrice;
  double? productQuantity;
  int selectedQuantity = 0;
  String? selectedImageUrl;
  List<ProductSelectProperty> selectProperties = [];
  List<ProductTypingProperty> typingProperties = [];

  List<ProductRating> ratings = [];
  int ratingPageSize = 2;
  int ratingPageNumber = 0;
  int totalRatings = 0;
  bool isLoadMoreRatings = false;

  Future<void> initializePage(int productId) async {
    var product = await ProductDetailService().get(productId);
    productDetail = product;
    selectedImageUrl = productDetail?.avatarUrl;
    selectedQuantity = 0;
    productPrice = null;
    productQuantity = null;

    ratingPageNumber = 0;
    totalRatings = 0;

    selectedVariantOptions = product.variants
        .map((variant) =>
            SelectedVariantOption(variant.id, variant.options[0].id))
        .toList();

    recalculateQuantityAndPrice();
    resetSelectedQuantity();

    notifyListeners();
  }

  selectVariantOption(int variantId, int optionId) {
    for (var selectedOption in selectedVariantOptions) {
      if (selectedOption.variantId == variantId) {
        selectedOption.optionId = optionId;
      }
    }

    recalculateQuantityAndPrice();
    resetSelectedQuantity();

    notifyListeners();
  }

  recalculateQuantityAndPrice() {
    if (productDetail == null) return;

    double? price = null;
    int? quantity = null;

    if (productDetail?.variants.length == 0) {
      productPrice = productDetail?.price;
      productQuantity = productDetail?.quantity;

      return;
    }

    final selectedOptionIds = selectedVariantOptions.map((s) => s.optionId);
    for (var combination in (productDetail as ProductDetail).combinations) {
      if (selectedOptionIds.contains(combination.firstValueId)) {
        if (combination.secondValueId == null) {
          price = combination.price;
          quantity = combination.quantity;

          productPrice = price;
          productQuantity = quantity.toDouble();
          notifyListeners();

          return;
        } else {
          if (selectedOptionIds.contains(combination.secondValueId)) {
            price = combination.price;
            quantity = combination.quantity;

            productPrice = price;
            productQuantity = quantity.toDouble();
            notifyListeners();

            return;
          }
        }
      }
    }

    productPrice = price;
    productQuantity = quantity?.toDouble();
    notifyListeners();
  }

  resetSelectedQuantity() {
    if (productQuantity == null || productQuantity == 0) {
      selectedQuantity = 0;
      notifyListeners();
      return;
    }

    selectedQuantity = 1;
    notifyListeners();
  }

  selectQuantity(int newQuantity) {
    if (productQuantity == null || productQuantity! <= 0) {
      selectedQuantity = 0;
      notifyListeners();
      return;
    }

    if (newQuantity < 0) {
      selectedQuantity = 0;
      notifyListeners();
      return;
    }

    if (newQuantity.toDouble() > (productQuantity as double)) {
      selectedQuantity = ((productQuantity as double).toInt());
      notifyListeners();
      return;
    }

    selectedQuantity = newQuantity;
    notifyListeners();
  }

  Future<void> reloadProperties(int productId) async {
    var model = await ProductDetailService().getProperties(productId);

    if (model != null) {
      selectProperties = model.selectProperties;
      typingProperties = model.typingProperties;

      notifyListeners();
    }
  }

  Future<void> reloadRatings(int productId) async {
    if (productId != 0) {
      final response = await ProductDetailService().getRatings(
        productId,
        pageSize: ratingPageSize,
        pageNumber: ratingPageNumber,
      );

      ratings = response.productsRatings;
      totalRatings = response.totalRatings;

      notifyListeners();
    }
  }

  Future<void> loadMoreRatings(int productId) async {
    if (!canLoadMoreRatings()) return;

    ratingPageNumber++;
    isLoadMoreRatings = true;
    notifyListeners();

    final response = await ProductDetailService().getRatings(
      productId,
      pageSize: ratingPageSize,
      pageNumber: ratingPageNumber,
    );

    ratings.addAll(response.productsRatings);
    totalRatings = response.totalRatings;

    isLoadMoreRatings = false;
    notifyListeners();
  }

  //getter
  bool canLoadMoreRatings() {
    return (ratingPageNumber + 1) * ratingPageSize < totalRatings;
  }

  ProductCombination? getSelectedCombination() {
    if (productDetail == null) return null;

    final selectedOptions = selectedVariantOptions;

    for (var combination in productDetail!.combinations) {
      if (selectedOptions.indexWhere(
              (option) => option.optionId == combination.firstValueId) !=
          -1) {
        if (combination.secondValueId != null) {
          if (selectedOptions.indexWhere(
                  (option) => option.optionId == combination.secondValueId) !=
              -1) {
            return combination;
          }
        } else {
          return combination;
        }
      }
    }

    return null;
  }
}
