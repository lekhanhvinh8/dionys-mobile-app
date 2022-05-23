import 'package:dionys/app/models/cartGroup.dart';
import 'package:dionys/app/services/cartService.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<CartGroup> cartGroups = [];

  Future<String?> addToCart(
      int productId, int? combinationId, int amount, String token) async {
    try {
      if (amount == 0) return null;

      final productIdToCart = combinationId != null ? null : productId;

      final response = await CartService(token)
          .addToCart(productIdToCart, combinationId, amount);

      if (response.cartGroup != null) {
        final newCartGroup = response.cartGroup;

        if (newCartGroup?.items.length == 0) return null;

        final groupIndex = cartGroups.indexWhere(
            (cartGroup) => cartGroup.shopId == newCartGroup?.shopId);
        if (groupIndex != -1) {
          cartGroups[groupIndex].items.add(newCartGroup!.items[0]);
          notifyListeners();
        } else {
          cartGroups.add(newCartGroup!);
          notifyListeners();
        }

        return "Thêm vào giỏ hàng thành công";
      } else if (response.errorMessage != null) {
        return response.errorMessage;
      }

      return null;
    } catch (ex) {}
  }

  Future<void> changeItemAmount(int itemId, int newAmount, String token) async {
    for (var cartGroup in cartGroups) {
      for (var cartItem in cartGroup.items) {
        if (cartItem.id == itemId) {
          if (newAmount <= 0) {
            return;
          }
          if (newAmount > cartItem.quantity) {
            await CartService(token)
                .changeCartAmount(itemId, cartItem.quantity);
            cartItem.amount = cartItem.quantity;
            notifyListeners();
            return;
          } else {
            await CartService(token).changeCartAmount(itemId, newAmount);
            cartItem.amount = newAmount;
            notifyListeners();
            return;
          }
        }
      }
    }
  }

  Future<void> removeCart(int cartId, String token) async {
    final isSuccess = await CartService(token).deleteCart(cartId);

    if (isSuccess) {
      for (var cartGroup in cartGroups) {
        for (var cartItem in cartGroup.items) {
          if (cartItem.id == cartId) {
            cartGroup.items.remove(cartItem);
            notifyListeners();
            return;
          }
        }
      }
    }

    return;
  }

  Future<void> loadCarts(String token) async {
    cartGroups = await CartService(token).getCarts();
    notifyListeners();
  }

  void initializePage() {
    for (var i = 0; i < cartGroups.length; i++) {
      final cartGroup = cartGroups[i];

      for (var j = 0; j < cartGroup.items.length; j++) {
        final cartItem = cartGroup.items[j];

        if (cartItem.amount > cartItem.quantity) cartItem.disabled = true;
      }
    }

    notifyListeners();
  }

  void checkAll(bool checked) {
    for (var cartGroup in cartGroups) {
      for (var cartItem in cartGroup.items) {
        cartItem.checked = checked;
      }
    }

    notifyListeners();
  }

  void checkCartGroup(int shopId, bool checked) {
    final index =
        cartGroups.indexWhere((cartGroup) => cartGroup.shopId == shopId);

    if (index != -1) {
      for (var cartItem in cartGroups[index].items) {
        cartItem.checked = checked;
      }
    }

    notifyListeners();
  }

  void checkCartItem(int cartItemId, bool checked) {
    for (var cartGroup in cartGroups) {
      final itemIndex =
          cartGroup.items.indexWhere((item) => item.id == cartItemId);

      if (itemIndex != -1) {
        final cartItem = cartGroup.items[itemIndex];
        if (cartItem.disabled) return;

        cartItem.checked = checked;
        notifyListeners();
      }
    }
  }

  //getter
  int numberOfItem() {
    var counter = 0;
    for (var cartGroup in cartGroups) {
      counter += cartGroup.items.length;
    }

    return counter;
  }

  bool isGroupChecked(shopId) {
    final groupIndex = cartGroups.indexWhere((group) => group.shopId == shopId);
    if (groupIndex != -1) {
      for (var item in cartGroups[groupIndex].items) {
        if (item.checked == false) return false;
      }

      return true;
    }

    return false;
  }

  bool isAllChecked() {
    for (var group in cartGroups) {
      for (var item in group.items) {
        if (!item.checked) return false;
      }
    }

    return true;
  }

  double getProvisionalPrice() {
    double sum = 0;

    for (var i = 0; i < cartGroups.length; i++) {
      final cartGroup = cartGroups[i];

      if (cartGroup.items.length > 0) {
        for (var j = 0; j < cartGroup.items.length; j++) {
          final cartItem = cartGroup.items[j];

          if (cartItem.checked) {
            sum += cartItem.amount * cartItem.price.toDouble();
          }
        }
      }
    }

    return sum;
  }
}
