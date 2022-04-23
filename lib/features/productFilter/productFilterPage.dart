import 'package:dionys/features/header/header.dart';
import 'package:dionys/features/productFilter/filters.dart';
import 'package:dionys/features/productFilter/productFilter.dart';
import 'package:flutter/material.dart';

class ProductFilterPage extends StatelessWidget {
  String? searchKey;
  int? categoryId;

  ProductFilterPage({Key? key, this.searchKey, this.categoryId})
      : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Filters(),
        key: _key,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Header(),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.red,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3),
                        child: Text("Lọc"),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),
                onTap: () => _key.currentState!.openDrawer(),
              ),
              Expanded(
                  child: ProductFilter(
                      searchKey: searchKey, categoryId: categoryId))
            ],
          ),
        ));
  }
}
