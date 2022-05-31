import 'package:dionys/app/models/address.dart';
import 'package:dionys/app/models/cartGroup.dart';
import 'package:dionys/app/services/orderService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeliveryTime {
  int shopId;
  String? time;

  DeliveryTime(this.shopId, this.time);
}

class ShippingCost {
  int shopId;
  double? cost;

  ShippingCost(this.shopId, this.cost);
}

void showSuccessToast(context) {
  final fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: InkWell(
      onTap: () {
        fToast.removeCustomToast();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Đặt hàng thành công"),
        ],
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 4),
  );

  // Custom Toast Position
  // fToast.showToast(
  //     child: toast,
  //     toastDuration: Duration(seconds: 2),
  //     positionedToastBuilder: (context, child) {
  //       return Positioned(
  //         child: child,
  //         top: 16.0,
  //         left: 16.0,
  //       );
  //     });
}

class CheckoutProvider with ChangeNotifier {
  int? selectedAddressId;
  int? tempSelectedAddressId;
  String selectedPaymentMethod = "COD";
  List<DeliveryTime> expectedDeliveryTimes = [];
  List<ShippingCost> shippingCosts = [];
  bool pageReloading = false;
  bool orderLoading = false;

  void selectAddressId(int? addressId) {
    selectedAddressId = addressId;
    notifyListeners();
  }

  Future<void> captureOrder(
      String paypalOrderId, String token, BuildContext context) async {
    pageReloading = true;
    notifyListeners();

    final orderId = await OrderService(token).capturePaypalOrder(paypalOrderId);

    pageReloading = false;
    notifyListeners();

    if (orderId != null) {
      showSuccessToast(context);
    }
  }

  Future<void> reloadExpectedDeliveryTimeAndShippingCost(
      List<CartGroup> cartGroups, String token) async {
    if (selectedAddressId == null) return;

    pageReloading = true;
    notifyListeners();

    //initialize deliveryTimes
    List<DeliveryTime> expectedDeliveryTimes = [];

    for (var group in cartGroups) {
      String? expectedDeliveryTime;

      final hasAnyItemChecked = group.items.any((item) => item.checked);

      if (hasAnyItemChecked) {
        expectedDeliveryTime = await OrderService(token)
            .getExpectedDeliveryTime(selectedAddressId!, group.shopId);
      }

      expectedDeliveryTimes
          .add(DeliveryTime(group.shopId, expectedDeliveryTime));
    }

    //initialize shippingCost;
    List<ShippingCost> shippingCosts = [];
    for (var group in cartGroups) {
      double? shippingCost;

      final hasAnyItemChecked = group.items.any((item) => item.checked);

      if (hasAnyItemChecked) {
        final checkedCartIds = group.items
            .where((item) => item.checked)
            .map((item) => item.id)
            .toList();

        shippingCost = await OrderService(token)
            .getShippingCost(checkedCartIds, selectedAddressId!);
      }

      shippingCosts.add(ShippingCost(group.shopId, shippingCost));
    }

    this.expectedDeliveryTimes = expectedDeliveryTimes;
    this.shippingCosts = shippingCosts;

    pageReloading = false;
    notifyListeners();
  }

  Future<void> initializeCheckoutPage(
    List<Address> addresses,
    List<CartGroup> cartGroups,
    String token,
  ) async {
    if (cartGroups.isEmpty) {
      return;
    }

    if (addresses.isEmpty) {
      return;
    }

    pageReloading = true;
    notifyListeners();

    //initialize selected address
    int? selectedAddressId;

    final defaultAddresses =
        addresses.where((address) => address.isDefault).toList();
    selectedAddressId =
        defaultAddresses.isEmpty ? addresses[0].id : defaultAddresses[0].id;

    //initialize deliveryTimes
    List<DeliveryTime> expectedDeliveryTimes = [];

    for (var group in cartGroups) {
      String? expectedDeliveryTime;

      final hasAnyItemChecked = group.items.any((item) => item.checked);

      if (hasAnyItemChecked) {
        expectedDeliveryTime = await OrderService(token)
            .getExpectedDeliveryTime(selectedAddressId, group.shopId);
      }

      expectedDeliveryTimes
          .add(DeliveryTime(group.shopId, expectedDeliveryTime));
    }

    //initialize shippingCost;
    List<ShippingCost> shippingCosts = [];
    for (var group in cartGroups) {
      double? shippingCost;

      final hasAnyItemChecked = group.items.any((item) => item.checked);

      if (hasAnyItemChecked) {
        final checkedCartIds = group.items
            .where((item) => item.checked)
            .map((item) => item.id)
            .toList();

        shippingCost = await OrderService(token)
            .getShippingCost(checkedCartIds, selectedAddressId);
      }

      shippingCosts.add(ShippingCost(group.shopId, shippingCost));
    }

    this.selectedAddressId = selectedAddressId;
    tempSelectedAddressId = selectedAddressId;
    this.expectedDeliveryTimes = expectedDeliveryTimes;
    this.shippingCosts = shippingCosts;

    pageReloading = false;
    notifyListeners();
  }

  //getter

  double getTotalCost(List<CartGroup> cartGroups) {
    double total = 0;

    for (var group in cartGroups) {
      total += getTotalCostOfGroup(group);
    }

    return total;
  }

  double getTotalCostOfGroup(CartGroup cartGroup) {
    final shippingCostIndex =
        shippingCosts.indexWhere((cost) => cost.shopId == cartGroup.shopId);

    double? shippingCost;

    if (shippingCostIndex != -1) {
      shippingCost = shippingCosts[shippingCostIndex].cost;
    }

    double total = 0;

    for (var item in cartGroup.items) {
      total += item.price * item.amount;
    }

    return shippingCost == null ? total : total + shippingCost;
  }
}
