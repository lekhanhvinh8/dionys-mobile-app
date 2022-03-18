import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderCategories extends StatelessWidget {
  const SliderCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const categories = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
      "13"
    ];

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 30,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: const [Text("Danh mục")],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.3,
              child: ListView.builder(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: LayoutBuilder(builder: ((context, constraints) {
                        return Column(
                          children: [
                            Container(
                              width: constraints.maxWidth,
                              height: constraints.maxWidth,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/categories/cate1.png'),
                                    fit: BoxFit.cover),
                                color: Colors.blue,
                              ),
                            ),
                            const Expanded(child: Text("Điện thoại"))
                          ],
                        );
                      })));
                },
              ),
            ),
          ],
        ));
  }
}
