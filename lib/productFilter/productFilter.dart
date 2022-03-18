import 'package:flutter/material.dart';

class ProductFilter extends StatelessWidget {
  const ProductFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((ctx, constraints) {
      return Container(
        height: constraints.maxHeight,
        child: Column(
          children: [
            Container(
              width: constraints.maxWidth,
              padding: const EdgeInsets.all(5),
              child: const Text("Sản phẩm"),
            ),
            Expanded(child: LayoutBuilder(
              builder: ((context, constraints) {
                return Container(
                  width: constraints.maxWidth,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(10),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    children: <Widget>[
                      LayoutBuilder(builder: ((context, constraints) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                height: constraints.maxWidth,
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/categories/cate1.png'),
                                      fit: BoxFit.cover),
                                  color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: constraints.maxWidth,
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      const Text('Sản phẩm giày hot nhất 2021'),
                                  color: Colors.red[200],
                                ),
                              )
                            ],
                          ),
                          color: Colors.teal[100],
                        );
                      })),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Heed not the rabble'),
                        color: Colors.teal[200],
                      ),
                      LayoutBuilder(builder: ((context, constraints) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                height: constraints.maxWidth,
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/categories/cate1.png'),
                                      fit: BoxFit.cover),
                                  color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: constraints.maxWidth,
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      const Text('Sản phẩm giày hot nhất 2021'),
                                  color: Colors.red[200],
                                ),
                              )
                            ],
                          ),
                          color: Colors.teal[100],
                        );
                      })),
                      LayoutBuilder(builder: ((context, constraints) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                height: constraints.maxWidth,
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/categories/cate1.png'),
                                      fit: BoxFit.cover),
                                  color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: constraints.maxWidth,
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      const Text('Sản phẩm giày hot nhất 2021'),
                                  color: Colors.red[200],
                                ),
                              )
                            ],
                          ),
                          color: Colors.teal[100],
                        );
                      })),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Revolution is coming...'),
                        color: Colors.teal[500],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Revolution, they...'),
                        color: Colors.teal[600],
                      ),
                    ],
                  ),
                );
              }),
            ))
          ],
        ),
      );
    }));
  }
}
