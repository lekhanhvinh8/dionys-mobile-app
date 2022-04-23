import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:dionys/features/header/header.dart';
import 'package:dionys/features/productDetail/carouselImages.dart';
import 'package:dionys/features/productDetail/productBasicInfo.dart';
import 'package:dionys/features/productDetail/productDetailInfo.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final productDetailProvider = Provider.of<ProductDetailProvider>(context);
    var product = productDetailProvider.productDetail;

    var maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomSheet: InkWell(
        child: Container(
            padding: EdgeInsets.all(10),
            width: maxWidth,
            color: Colors.red,
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
            children: const [
              Header(),
              CarouselImages(),
              ProductBasicInfo(),
              ProductDetailInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
