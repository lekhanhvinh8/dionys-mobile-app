import 'package:dionys/header/header.dart';
import 'package:dionys/home/sliderCategories.dart';
import 'package:dionys/productDetail/productDetail.dart';
import 'package:dionys/productFilter/productFilter.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: const <Widget>[Header(), Expanded(child: ProductFilter())],
      ),
    ));
  }
}
