import 'package:badges/badges.dart';
import 'package:dionys/features/cart/cartPage.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      height: 80,
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LayoutBuilder(builder: ((context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: (MediaQuery.of(context).size.width - 20) * 0.85,
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                color: Colors.tealAccent,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm kiến sản phẩm",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                  )
                ],
              ),
            );
          })),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            child: Badge(
              badgeContent: const Text('3'),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
