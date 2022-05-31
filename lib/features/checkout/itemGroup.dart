import 'package:dionys/app/models/cartGroup.dart';
import 'package:dionys/app/providers/checkoutProvider.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:dionys/features/checkout/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemGroup extends StatelessWidget {
  CartGroup cartGroup;
  ItemGroup({Key? key, required this.cartGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    final expectedDeliveryTimeIndex = checkoutProvider.expectedDeliveryTimes
        .indexWhere((time) => time.shopId == cartGroup.shopId);
    final shippingCostIndex = checkoutProvider.shippingCosts
        .indexWhere((cost) => cost.shopId == cartGroup.shopId);

    final expectedDeliveryTime = expectedDeliveryTimeIndex == -1
        ? ""
        : checkoutProvider
            .expectedDeliveryTimes[expectedDeliveryTimeIndex].time;

    double zero = 0;
    final double? shippingCost = (shippingCostIndex == -1)
        ? zero
        : checkoutProvider.shippingCosts[shippingCostIndex].cost;

    return Container(
      child: Column(
        children: [
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            padding: EdgeInsets.all(7),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.store_outlined,
                        color: Colors.red,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(cartGroup.shopName),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            margin: const EdgeInsets.only(top: 3),
            child: Column(
              children: cartGroup.items
                  .map((item) => Container(
                        margin: const EdgeInsets.only(bottom: 3),
                        color: const Color.fromRGBO(245, 245, 245, 1),
                        child: Item(cartItem: item),
                      ))
                  .toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(maxWidth * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      color: Colors.blue,
                    ),
                    Row(
                      children: [
                        Text("Phí vận chuyển: "),
                        Text(
                          Formator.formatMoney(
                              shippingCost == null ? 0 : shippingCost),
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Giao hàng dự kiến vào: " +
                        (expectedDeliveryTime == null
                            ? ""
                            : expectedDeliveryTime.split(" ")[0])),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(maxWidth * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Tổng số tiền: "),
                Text(
                    Formator.formatMoney(
                        checkoutProvider.getTotalCostOfGroup(cartGroup)),
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
