import 'package:dionys/app/models/productVariant.dart';
import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:dionys/features/productDetail/quantitySelection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VariantSelection extends StatelessWidget {
  const VariantSelection({Key? key}) : super(key: key);

  bool isContain(List<SelectedVariantOption> selectedOptions, int variantId,
      int optionId) {
    if (selectedOptions.indexWhere((selectedOption) =>
            selectedOption.variantId == variantId &&
            selectedOption.optionId == optionId) !=
        -1) return true;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductDetailProvider>(context);
    final variants = productProvider.productDetail?.variants;
    final selectedOptions = productProvider.selectedVariantOptions;

    // for (var item in selectedOptions) {
    //   print(item.variantId.toString() + " " + item.optionId.toString());
    // }

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Chọn phân loại hàng"),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 13,
                color: Colors.grey,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (variants == null)
                  ? []
                  : (variants)
                      .map((variant) => Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(variant.name),
                              ),
                              Row(
                                children: variant.options
                                    .map((option) => Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: OutlinedButton(
                                              style: ButtonStyle(),
                                              onPressed: () {
                                                productProvider
                                                    .selectVariantOption(
                                                        variant.id, option.id);
                                              },
                                              child: Row(
                                                children: [
                                                  Text(option.name),
                                                  if (isContain(selectedOptions,
                                                      variant.id, option.id))
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 3),
                                                      child: Icon(
                                                        Icons.done,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                ],
                                              )),
                                        ))
                                    .toList(),
                              ),
                            ],
                          )))
                      .toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text("Chọn số lượng hàng"),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(children: [
              QuantitySelection(),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Kho hàng: " +
                        ((productProvider.productQuantity == null)
                            ? "0"
                            : productProvider.productQuantity.toString()),
                  ))
            ]),
          ),
        ],
      ),
    );
  }

  showMenu(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: Color(0xff232f34),
              ),
              child: Text("sad"));
        });
  }
}
