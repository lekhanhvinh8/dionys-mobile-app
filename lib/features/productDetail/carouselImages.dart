import 'package:carousel_slider/carousel_slider.dart';
import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselImages extends StatelessWidget {
  const CarouselImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailProvider = Provider.of<ProductDetailProvider>(context);
    final avatar = productDetailProvider.productDetail?.avatarUrl;
    final avatarUrls = productDetailProvider.productDetail?.imageUrls;

    final List<String> imageUrls = [];
    if (avatar != null) imageUrls.add(avatar);
    if (avatarUrls != null) imageUrls.addAll(avatarUrls);

    var imageWidgets = imageUrls
        .map((imageUrl) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: (imageUrl == "")
                        ? AssetImage('categories/cate1.png') as ImageProvider
                        : NetworkImage(imageUrl),
                    fit: BoxFit.cover),
              ),
            ))
        .toList();

    return CarouselSlider(
        items: imageWidgets,
        options: CarouselOptions(
          height: 400,
          aspectRatio: 1,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          //enlargeCenterPage: true,
          //onPageChanged:,
          scrollDirection: Axis.horizontal,
        ));
  }
}
