import 'package:dionys/app/models/productDetail.dart';
import 'package:dionys/app/services/productDetailService.dart';
import 'package:flutter/material.dart';

class SelectedVariantValue {
  int variantId;
  int variantValueId;

  SelectedVariantValue(this.variantId, this.variantValueId);
}

class ProductDetailProvider with ChangeNotifier {
  ProductDetail? productDetail;
  List<SelectedVariantValue> selectedVariantValues = [];
  double? productPrice;
  double? productQuantity;
  int selectedQuantity = 0;
  String? selectedImageUrl;

  Future<void> initializePage(int productId) async {
    var product = await ProductDetailService().get(productId);
    productDetail = product;
    selectedImageUrl = productDetail?.avatarUrl;
    selectedQuantity = 0;
    productPrice = null;
    productQuantity = null;

    selectedVariantValues = product.variants
        .map((variant) =>
            SelectedVariantValue(variant.id, variant.options[0].id))
        .toList();

    notifyListeners();
  }
}
