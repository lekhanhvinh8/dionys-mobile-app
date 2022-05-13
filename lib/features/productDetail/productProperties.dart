import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductProperties extends StatelessWidget {
  const ProductProperties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final productProvider = Provider.of<ProductDetailProvider>(context);
    final selectProperties = productProvider.selectProperties;
    final typingProperties = productProvider.typingProperties;

    return Container(
      child: Column(
        children: [
          ...selectProperties
              .map((selectProperty) => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(children: [
                      Container(
                        width: maxWidth * 0.4,
                        child: Text(
                          selectProperty.propertyName,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
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
          ...typingProperties
              .map((typingProperty) => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          width: maxWidth * 0.4,
                          child: Text(
                            typingProperty.propertyName,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Text(typingProperty.value),
                      ],
                    ),
                  ))
              .toList()
        ],
      ),
    );
  }
}
