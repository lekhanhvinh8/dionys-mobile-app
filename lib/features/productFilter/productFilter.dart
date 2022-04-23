import 'package:dionys/app/models/productCard.dart';
import 'package:dionys/app/providers/productsFilterProvider.dart';
import 'package:dionys/app/services/ProductFilterServices.dart';
import 'package:dionys/features/productFilter/gridProducts.dart';
import 'package:dionys/features/productFilter/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductFilter extends StatefulWidget {
  String? searchKey;
  int? categoryId;

  ProductFilter({Key? key, this.searchKey, this.categoryId}) : super(key: key);

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void initializePage() async {
    final productsFilterProvider =
        Provider.of<ProductsFilterProvider>(context, listen: false);
    productsFilterProvider.resetParams(widget.searchKey, widget.categoryId, 10);

    var result = await ProductFilterServices()
        .filter(productsFilterProvider.filterRequestParams);

    productsFilterProvider.loadProducts(result.products, result.totalProducts);
  }

  @override
  Widget build(BuildContext context) {
    final productsFilterProvider = Provider.of<ProductsFilterProvider>(context);
    var products = productsFilterProvider.products;
    var isReload = productsFilterProvider.isReload;

    return LayoutBuilder(builder: ((ctx, constraints) {
      return SizedBox(
        height: constraints.maxHeight,
        child: Column(
          children: [
            Expanded(child: LayoutBuilder(
              builder: ((context, constraints) {
                return Container(
                  width: constraints.maxWidth,
                  child: NotificationListener(
                    child: GridProducts(
                        products: products,
                        scrollController: _scrollController),
                    onNotification: (t) {
                      if (t is ScrollEndNotification) {
                        if (_scrollController.position.pixels ==
                            _scrollController.position.maxScrollExtent) {
                          if (!isReload) {
                            productsFilterProvider.loadMoreProducts();
                          }
                        }
                      }
                      return true;
                    },
                  ),
                  color: const Color.fromRGBO(240, 240, 240, 1),
                );
              }),
            )),
            if (isReload)
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(bottom: 3),
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
                color: const Color.fromRGBO(240, 240, 240, 1),
              ),
          ],
        ),
      );
    }));
  }
}
