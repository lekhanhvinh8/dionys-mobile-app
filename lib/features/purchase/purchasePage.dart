import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/purchaseProvider.dart';
import 'package:dionys/features/purchase/purchaseArea.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final purchaseProvider =
        Provider.of<PurchaseProvider>(context, listen: false);
    _tabController =
        TabController(vsync: this, length: purchaseProvider.tabs.length);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  void initializePage() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final purchaseProvider =
        Provider.of<PurchaseProvider>(context, listen: false);

    purchaseProvider.reloadOrders(
        purchaseProvider.tabs[0].statusCode, authProvider.token as String);
  }

  @override
  Widget build(BuildContext context) {
    final purchaseProvider = Provider.of<PurchaseProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final orders = purchaseProvider.orders;
    final tabs = purchaseProvider.tabs;

    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(240, 240, 240, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                onTap: (tabIndex) {
                  purchaseProvider.reloadOrders(
                      tabs[tabIndex].statusCode, authProvider.token as String);
                },
                isScrollable: true,
                controller: _tabController,
                tabs: tabs
                    .map(
                      (tab) => Tab(
                        child: Text(
                          tab.label,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabs
                    .map(
                      (tab) => PurchaseArea(tab: tab),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
