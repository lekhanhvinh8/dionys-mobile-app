import 'package:dionys/app/models/orderItem.dart';
import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/purchaseProvider.dart';
import 'package:dionys/features/purchase/orderGroupArea.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseArea extends StatefulWidget {
  TabOrder tab;
  PurchaseArea({Key? key, required this.tab}) : super(key: key);

  @override
  State<PurchaseArea> createState() => _PurchaseAreaState();
}

class _PurchaseAreaState extends State<PurchaseArea> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final purchaseProvider = Provider.of<PurchaseProvider>(context);
    final orders = purchaseProvider.orders;
    final isLoadMore = purchaseProvider.isLoadMore;

    final canLoadMore =
        purchaseProvider.pageSize * purchaseProvider.pageNumber <
            purchaseProvider.totalOrders;

    return Container(
      child: Column(
        children: [
          Expanded(
            child: NotificationListener(
              onNotification: (t) {
                if (t is ScrollEndNotification) {
                  if (_scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent) {
                    if (!isLoadMore) {
                      if (canLoadMore) {
                        purchaseProvider.loadMoreOrders(
                            authProvider.token as String,
                            widget.tab.statusCode);
                      }
                    }
                  }
                }
                return true;
              },
              child: ListView(
                controller: _scrollController,
                children: [
                  ...orders
                      .map((order) => OrderGroupArea(orderGroup: order))
                      .toList(),
                  if (canLoadMore)
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(bottom: 3),
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                      color: const Color.fromRGBO(240, 240, 240, 1),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
