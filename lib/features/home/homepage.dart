import 'package:dionys/app/models/productCard.dart';
import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/productsFilterProvider.dart';
import 'package:dionys/app/services/ProductFilterServices.dart';
import 'package:dionys/features/home/gridProducts.dart';
import 'package:dionys/features/home/sliderCategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  void initializePage() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final productsFilterProvider =
        Provider.of<ProductsFilterProvider>(context, listen: false);
    productsFilterProvider.resetParams(null, null, 10);

    var result = await ProductFilterServices()
        .filter(productsFilterProvider.filterRequestParams);

    productsFilterProvider.loadProducts(result.products, result.totalProducts);

    productsFilterProvider
        .loadRecommendedProducts(authProvider.token as String);
  }

  @override
  Widget build(BuildContext context) {
    final productsFilterProvider = Provider.of<ProductsFilterProvider>(context);
    final products = productsFilterProvider.recommendedProducts;

    return Scaffold(
      body: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Column(children: [
          SliderCategories(),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            child: Row(children: [Text("Sản phẩm gợi ý")]),
          ),
          Container(
            child: GridProducts(products: products),
          ),
        ])),
      ),
    );
  }
}
