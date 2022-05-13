import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductProperties extends StatelessWidget {
  const ProductProperties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductDetailProvider>(context);
    final selectProperties = productProvider.selectProperties;
    final typingProperties = productProvider.typingProperties;

    return Container(
      child: Column(
        children: selectProperties
            .map((selectProperty) => Container(
                  child: Row(children: [
                    Text(selectProperty.propertyName),
                    Container(
                      child: Row(
                        children: selectProperty.values
                            .map((value) => Text(value))
                            .toList(),
                      ),
                    )
                  ]),
                ))
            .toList(),
      ),
    );
  }
}
