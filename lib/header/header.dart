import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      height: 80,
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
                    FontAwesomeIcons.search,
                  )
                ],
              ),
            );
          })),
          const Icon(FontAwesomeIcons.cartPlus)
        ],
      ),
    );
  }
}
