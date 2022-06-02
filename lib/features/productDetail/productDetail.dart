import 'dart:convert';

import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:dionys/features/header/header.dart';
import 'package:dionys/features/productDetail/carouselImages.dart';
import 'package:dionys/features/productDetail/productBasicInfo.dart';
import 'package:dionys/features/productDetail/productDetailInfo.dart';
import 'package:dionys/features/productDetail/productRatings.dart';
import 'package:dionys/features/productDetail/variantsSelection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  int productId;
  ProductDetail({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  void initializePage() async {
    final productDetailProvider =
        Provider.of<ProductDetailProvider>(context, listen: false);

    await productDetailProvider.initializePage(widget.productId);
    await productDetailProvider.reloadProperties(widget.productId);
    await productDetailProvider.reloadRatings(widget.productId);
  }

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productDetailProvider = Provider.of<ProductDetailProvider>(context);
    var product = productDetailProvider.productDetail;

    final authProvider = Provider.of<AuthProvider>(context);

    final cartProvider = Provider.of<CartProvider>(context);

    var maxWidth = MediaQuery.of(context).size.width;

    var productReadyToCart = true;

    if (productDetailProvider.productPrice == null ||
        productDetailProvider.productQuantity == null ||
        productDetailProvider.selectedQuantity == 0) productReadyToCart = false;

    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          final combination = productDetailProvider.getSelectedCombination();
          final combinationId = (combination == null) ? null : combination.id;

          final amount = productDetailProvider.selectedQuantity;

          final message = await cartProvider.addToCart(
            product!.id,
            combinationId,
            amount,
            authProvider.token as String,
          );

          if (message != null) _showMyDialog(message as String);
        },
        child: Container(
            padding: EdgeInsets.all(10),
            width: maxWidth,
            color: productReadyToCart ? Colors.red : Colors.grey,
            child: Icon(
              Icons.add_shopping_cart,
              size: maxWidth * 0.07,
              color: Colors.white,
            )),
      ),
      body: Container(
        color: const Color.fromRGBO(240, 240, 240, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              CarouselImages(),
              ProductBasicInfo(),
              VariantSelection(),
              ProductDetailInfo(),
              ProductRatings(
                productId: widget.productId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
