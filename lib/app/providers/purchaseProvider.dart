import 'package:dionys/app/models/orderItem.dart';
import 'package:dionys/app/services/orderService.dart';
import 'package:flutter/foundation.dart';

class TabOrder {
  String? statusCode;
  String label = "";
  String tabName = "";
  String? step;

  TabOrder(
      {this.statusCode, required this.label, required this.tabName, this.step});
}

class PurchaseProvider with ChangeNotifier {
  String selectedTab = "";
  List<OrderGroup> orders = [];
  bool ordersReloading = false;
  int pageNumber = 0;
  int pageSize = 10;
  String searchKey = "";
  int totalOrders = 0;
  bool isLoadMore = false;

  List<TabOrder> tabs = [
    TabOrder(label: "Tất cả", tabName: "all"),
    TabOrder(
        statusCode: "PENDING_APPROVAL",
        label: "Chờ xác nhận",
        tabName: "pending",
        step: "Chờ xác nhận"),
    TabOrder(
        statusCode: "TO_PREPARE",
        label: "Đang chuẩn bị",
        tabName: "toPrepare",
        step: "Đã xác nhận"),
    TabOrder(
        statusCode: "TO_PICKUP",
        label: "Chờ lấy hàng",
        tabName: "toPickup",
        step: "Đã chuẩn bị hàng"),
    TabOrder(
        statusCode: "SHIPPING",
        label: "Đang giao",
        tabName: "shipping",
        step: "Shipper đã lấy hàng"),
    TabOrder(
        statusCode: "SHIPPED",
        label: "Đã giao",
        tabName: "shipped",
        step: "Đã giao hàng"),
    TabOrder(
        statusCode: "CANCELLED",
        label: "Đã hủy",
        tabName: "cancelled",
        step: "Đơn hàng đã hủy"),
  ];

  Future<void> reloadOrders(String? statusCode, String token) async {
    try {
      ordersReloading = true;
      notifyListeners();

      final result =
          await OrderService(token).getFilteredOrders(statusCode: statusCode);

      orders = result.orders;
      totalOrders = result.totalOrders;

      pageNumber = 0;
      ordersReloading = false;
      notifyListeners();
    } catch (ex) {
      ordersReloading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreOrders(String token, String? statusCode) async {
    try {
      // isLoadMore = true;
      // notifyListeners();

      final result = await OrderService(token).getFilteredOrders(
          statusCode: statusCode,
          pageSize: pageSize,
          pageNumber: pageNumber + 1);

      orders.addAll(result.orders);
      totalOrders = result.totalOrders;

      pageNumber++;
      //isLoadMore = false;
      notifyListeners();
    } catch (ex) {
      // isLoadMore = false;
      // notifyListeners();
    }
  }
}
