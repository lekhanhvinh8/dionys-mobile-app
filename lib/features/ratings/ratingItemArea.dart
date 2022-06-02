import 'package:dionys/app/providers/orderDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RatingItemArea extends StatefulWidget {
  RatingItem ratingItem;
  RatingItemArea({Key? key, required this.ratingItem}) : super(key: key);

  @override
  State<RatingItemArea> createState() => _RatingItemState();
}

class _RatingItemState extends State<RatingItemArea> {
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final orderDetailProvider = Provider.of<OrderDetailProvider>(context);
    final rating = widget.ratingItem;

    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: maxWidth * 0.1,
                height: maxWidth * 0.1,
                padding: EdgeInsets.all(maxWidth * 0.025),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: (rating == "")
                            ? const AssetImage('products/tainghe.jpg')
                                as ImageProvider
                            : NetworkImage(rating.productImageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(maxWidth * 0.025),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rating.productName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: "RobotoMono"),
                    ),
                  ],
                ),
              ))
            ],
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemSize: maxWidth * 0.1,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (stars) {
                orderDetailProvider.updateRating(rating.itemId, stars);
              },
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(25),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.green, spreadRadius: 3),
                ],
              ),
              padding: EdgeInsets.all(15),
              child: TextFormField(
                onChanged: (value) {
                  orderDetailProvider.updateContent(rating.itemId, value);
                },
                maxLines: 5,
                decoration: InputDecoration.collapsed(
                  hintText: "Nhập đánh giá của bạn",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
