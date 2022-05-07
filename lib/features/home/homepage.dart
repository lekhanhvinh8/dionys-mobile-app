import 'package:dionys/app/providers/productsFilterProvider.dart';
import 'package:dionys/app/services/ProductFilterServices.dart';
import 'package:dionys/features/header/header.dart';
import 'package:dionys/features/home/sliderCategories.dart';
import 'package:dionys/features/productFilter/gridProducts.dart';
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
    final productsFilterProvider =
        Provider.of<ProductsFilterProvider>(context, listen: false);
    productsFilterProvider.resetParams(null, null, 10);

    var result = await ProductFilterServices()
        .filter(productsFilterProvider.filterRequestParams);

    productsFilterProvider.loadProducts(result.products, result.totalProducts);
  }

  @override
  Widget build(BuildContext context) {
    final productsFilterProvider = Provider.of<ProductsFilterProvider>(context);
    var products = productsFilterProvider.products;

    return Scaffold(
        body: Container(
      color: Color.fromRGBO(245, 245, 245, 1),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Header(),
          SliderCategories(),
          Expanded(
              child: Column(children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              child: Row(children: [Text("Sản phẩm gọi ý")]),
            ),
            Expanded(
              child: Container(
                child: GridProducts(
                    products: products, scrollController: ScrollController()),
              ),
            )
          ]))
        ],
      ),
    ));
  }
}
