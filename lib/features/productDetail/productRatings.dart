import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductRatings extends StatefulWidget {
  final productId;
  const ProductRatings({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductRatings> createState() => _ProductRatingsState();
}

class _ProductRatingsState extends State<ProductRatings> {
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  void initializePage() async {}

  @override
  Widget build(BuildContext context) {
    final productDetailProvider = Provider.of<ProductDetailProvider>(context);
    final ratings = productDetailProvider.ratings;
    final isLoadMore = productDetailProvider.isLoadMoreRatings;
    final canLoadMore = productDetailProvider.canLoadMoreRatings();

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Đánh giá sản phẩm",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
          Container(
              child: Column(
            children: [
              ...ratings
                  .map((rating) => Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(rating.customerAvatarUrl),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(rating.customerEmail),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: RatingBar.builder(
                                        initialRating: rating.stars.toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemSize: 20,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (starts) {},
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(rating.content),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
              if (canLoadMore)
                Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 13),
                    ),
                    onPressed: () {
                      if (!isLoadMore) {
                        productDetailProvider.loadMoreRatings(widget.productId);
                      }
                    },
                    child: const Text('Tải thêm'),
                  ),
                  color: Colors.white,
                )
              else
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const Text('Không còn comment nào nữa'),
                ),
            ],
          )),
        ],
      ),
    );
  }
}
