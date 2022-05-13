import 'package:dionys/app/providers/productsFilterProvider.dart';
import 'package:dionys/app/services/ProductFilterServices.dart';
import 'package:dionys/features/cart/cartGroup.dart';
import 'package:dionys/features/cart/productsSelection.dart';
import 'package:dionys/features/cart/purchaseBottom.dart';
import 'package:dionys/features/header/header.dart';
import 'package:dionys/features/productFilter/gridProducts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  void initializePage() async {
    final productsFilterProvider =
        Provider.of<ProductsFilterProvider>(context, listen: false);
    productsFilterProvider.resetParams("", 5, 10);

    var result = await ProductFilterServices()
        .filter(productsFilterProvider.filterRequestParams);

    productsFilterProvider.loadProducts(result.products, result.totalProducts);
  }

  @override
  Widget build(BuildContext context) {
    final productsFilterProvider = Provider.of<ProductsFilterProvider>(context);
    var products = productsFilterProvider.products;
    var isReload = productsFilterProvider.isReload;

    return Scaffold(
        bottomNavigationBar: const PurchaseBottom(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70), // Set this height
            child: Container(
              color: Colors.white,
              height: 50,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(child: Icon(Icons.arrow_back, color: Colors.grey)),
                  Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Text(
                        "Giỏ hàng",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            )),
        body: Container(
            color: const Color.fromRGBO(240, 240, 240, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(children: [
                ProductsSelection(),
              ]),
            )));
  }
}
