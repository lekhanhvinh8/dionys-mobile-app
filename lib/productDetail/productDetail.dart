import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/categories/cate1.png'),
                  fit: BoxFit.cover),
              color: Colors.blue,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: const Text("Giỏ xách thời thượng hot nhất 2022"),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: const Text("Giá: 1.000.000đ"),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: const Text("Chi tiết: "),
          )
        ],
      ),
    );
  }
}
