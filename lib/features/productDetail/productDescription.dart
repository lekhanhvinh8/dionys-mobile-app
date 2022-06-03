import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key? key}) : super(key: key);
  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  // bool datatype to give toggle effect to button and
  // depending on this bool value will show full text or
  // limit the number of line to be viewed in text.
  bool isReadmore = false;
  @override
  Widget build(BuildContext context) {
    final productDetailProvider = Provider.of<ProductDetailProvider>(context);
    var product = productDetailProvider.productDetail;

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        buildText(product == null ? "" : product.description as String),
        ElevatedButton(
            onPressed: () {
              setState(() {
                // toggle the bool variable true or false
                isReadmore = !isReadmore;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((isReadmore ? 'Read Less' : 'Read More')),
                !isReadmore
                    ? Icon(Icons.keyboard_arrow_down)
                    : Icon(Icons.keyboard_arrow_up_outlined)
              ],
            ))
      ],
    );
  }

  Widget buildText(String text) {
    // if read more is false then show only 3 lines from text
    // else show full text
    final lines = isReadmore ? null : 5;
    return Text(
      text,
      style: TextStyle(),
      maxLines: lines,
      // overflow properties is used to show 3 dot in text widget
      // so that user can understand there are few more line to read.
      overflow: isReadmore ? TextOverflow.visible : TextOverflow.ellipsis,
    );
  }
}
