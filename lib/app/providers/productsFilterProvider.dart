import 'package:dionys/app/models/productCard.dart';
import 'package:dionys/app/services/ProductFilterServices.dart';
import 'package:flutter/material.dart';

class ProductsFilterProvider with ChangeNotifier {
  bool isReload = false;
  bool drawerOpen = false;
  List<ProductCard> products = [];
  int totalProducts = 0;
  FilterRequestParams filterRequestParams = FilterRequestParams();

  void setReload(bool isReload) {
    this.isReload = isReload;
    notifyListeners();
  }

  void loadMoreProducts() async {
    if ((filterRequestParams.pageNumber + 1) * filterRequestParams.pageSize >=
        totalProducts) return;

    setReload(true);

    filterRequestParams.pageNumber++;
    notifyListeners();

    var result = await ProductFilterServices().filter(filterRequestParams);

    setReload(false);
    loadProducts(result.products, result.totalProducts);
  }

  void resetParams(String? searchKey, int? categoryId, int pageSize) {
    filterRequestParams = FilterRequestParams(
        searchKey: searchKey, categoryId: categoryId, pageSize: pageSize);

    products.clear();
    totalProducts = 0;

    notifyListeners();
  }

  void loadProducts(List<ProductCard> products, int totalProducts) {
    this.products.addAll(products);
    this.totalProducts = totalProducts;

    notifyListeners();
  }
}
