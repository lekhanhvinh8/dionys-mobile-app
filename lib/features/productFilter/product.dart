import 'package:dionys/app/models/productCard.dart';
import 'package:dionys/app/utils/Formator.dart';
import 'package:dionys/features/productDetail/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Product extends StatelessWidget {
  final ProductCard product;
  const Product({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return InkWell(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(
                      productId: product.id,
                    )),
          )
        },
        child: Container(
          child: Column(
            children: [
              Container(
                width: constraints.maxWidth,
                height: constraints.maxWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: (product.avatarUrl == null)
                          ? AssetImage('assets/categories/cate1.png')
                              as ImageProvider
                          : NetworkImage(product.avatarUrl),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxWidth * 0.2,
                padding: EdgeInsets.fromLTRB(constraints.maxWidth * 0.05, 0,
                    constraints.maxWidth * 0.05, 0),
                margin: EdgeInsets.only(top: constraints.maxWidth * 0.05),
                child: Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: constraints.maxWidth * 0.08),
                ),
              ),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxWidth * 0.13,
                padding: EdgeInsets.fromLTRB(constraints.maxWidth * 0.05, 0,
                    constraints.maxWidth * 0.05, 0),
                margin: EdgeInsets.only(top: constraints.maxWidth * 0.05),
                child: Text(Formator.formatMoney(product.price) + " ₫",
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.12,
                      color: Colors.red,
                    )),
              ),
              Container(
                  width: constraints.maxWidth,
                  height: constraints.maxWidth * 0.1,
                  padding: EdgeInsets.fromLTRB(constraints.maxWidth * 0.05, 0,
                      constraints.maxWidth * 0.05, 0),
                  margin: EdgeInsets.only(top: constraints.maxWidth * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: constraints.maxWidth * 0.09,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Text(
                        " Đã bán " + product.quantitySold.toString(),
                        style: TextStyle(fontSize: constraints.maxWidth * 0.07),
                      )
                    ],
                  )),
              Container(
                width: constraints.maxWidth,
                height: constraints.maxWidth * 0.1,
                padding: EdgeInsets.fromLTRB(constraints.maxWidth * 0.05, 0,
                    constraints.maxWidth * 0.05, 0),
                margin: EdgeInsets.only(top: constraints.maxWidth * 0.05),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 15,
                    ),
                    Text(
                      product.shopAddressProvince,
                      style: TextStyle(fontSize: constraints.maxWidth * 0.07),
                    )
                  ],
                ),
              ),
            ],
          ),
          color: Colors.white,
        ),
      );
    }));
  }
}
