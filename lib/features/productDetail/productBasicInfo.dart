import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductBasicInfo extends StatelessWidget {
  const ProductBasicInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailProvider = Provider.of<ProductDetailProvider>(context);
    var product = productDetailProvider.productDetail;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(12),
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: product == null
            ? []
            : [
                Text(product.name,
                    style: TextStyle(
                      fontSize: width * 0.05,
                    )),
                Text(Formator.formatMoney(100000) + " ₫",
                    style: TextStyle(
                      fontSize: width * 0.07,
                      color: Colors.red,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: width * 0.05,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            " Đã bán " + product.quantitySold.toString(),
                            style: TextStyle(fontSize: width * 0.04),
                          ))
                    ],
                  ),
                )
              ],
      ),
    );
  }
}
