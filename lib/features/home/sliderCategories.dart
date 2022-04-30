import 'package:dionys/app/providers/categories.dart';
import 'package:dionys/features/productFilter/productFilterPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderCategories extends StatelessWidget {
  const SliderCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<Categories>(context);
    var categories = categoryProvider.categories;
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 30,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: const [Text("Danh mục")],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 2),
              height: MediaQuery.of(context).size.width * 0.33,
              child: ListView.builder(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductFilterPage(
                                  categoryId: categories[index].id,
                                )),
                      );
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: LayoutBuilder(builder: ((context, constraints) {
                          return Column(
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                height: constraints.maxWidth,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: categories[index].imageUrl == null
                                          ? AssetImage(
                                                  '/categories/defaultCategoryImage.png')
                                              as ImageProvider
                                          : NetworkImage(
                                              categories[index].imageUrl),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                categories[index].name,
                                textAlign: TextAlign.center,
                              ))
                            ],
                          );
                        }))),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
