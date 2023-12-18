import 'package:get/get.dart';

import '../../../constants/app_helper.dart';
import '../../../constants/app_strings.dart';
import '../../../models/cart_item.dart';
import '../../../models/data_result.dart';
import '../../../models/product.dart';
import '../../../models/response_status.dart';
import '../repository/cart_repo.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  var selectedCartIndex = 0.obs;
  var removingFromCart = false.obs;
  var addingToCart = false.obs;

  addToCart(Product product, {String? msg}) {
    if (!addingToCart.value) {
      final existingCart = cartItems.firstWhere((cart) => cart.product?.id == product.id, orElse: () => CartItem());
      if (existingCart.qty != null) {
        final CartItem cartItem = existingCart;
        cartItem.qty = cartItem.qty != null ? cartItem.qty! + 1 : 0;
        int index = cartItems.indexOf(existingCart);
        cartItems.removeAt(index);
        cartItems.insert(index, cartItem);

        AppHelper.showToast(message: msg ?? "Added");

        addToCartOnServer(product.id ?? "");
        addingToCart.value = false;
      } else {
        final CartItem cartItem = CartItem()
          ..product = product
          ..qty = 1;
        cartItems.add(cartItem);
        AppHelper.showToast(message: "Added");
        addToCartOnServer(product.id ?? "");
        addingToCart.value = false;
      }
    }
  }

  addToCartOnServer(String productId) async {
    final response = await CartRepo.addToCart(productId);
    if (response.error == null) {
      final status = response.data != null ? response.data as ResponseStatus : ResponseStatus();

      bool success = status.success ?? false;

      if (success) {
        //
      } else {
        AppHelper.showAlert(title: "Opps", message: status.message ?? "");
      }
      //
    } else if (response.error == AppString.unAuthenticated) {
      AppHelper.logout();
    } else if (response.error == AppString.noInternetConnection) {
      AppHelper.showAlert(title: "No Internet", message: AppString.noInternetConnection);
    } else {
      AppHelper.showAlert(title: "Opps", message: response.error ?? "");
    }
  }

  removeFromCartOnServer(String productId) async {
    final response = await CartRepo.removeFromCart(productId);
    if (response.error == null) {
      final status = response.data != null ? response.data as ResponseStatus : ResponseStatus();

      bool success = status.success ?? false;

      if (success) {
        //
      } else {
        AppHelper.showAlert(title: "Opps", message: status.message ?? "");
      }
      //
    } else if (response.error == AppString.unAuthenticated) {
      AppHelper.logout();
    } else if (response.error == AppString.noInternetConnection) {
      AppHelper.showAlert(title: "No Internet", message: AppString.noInternetConnection);
    } else {
      AppHelper.showAlert(title: "Opps", message: response.error ?? "");
    }
  }

  removeItemFromCart({required CartItem cartItem, required CartItem oldCartItem, required int index, required String productId}) async {
    if (!removingFromCart.value) {
      removingFromCart.value = true;

      if (cartItem.qty != null) {
        cartItem.qty = cartItem.qty! - 1;

        if (cartItem.qty! <= 0) {
          cartItems.removeAt(index);
        } else {
          cartItems.removeAt(index);
          cartItems.insert(index, cartItem);
        }

        AppHelper.showToast(message: "কার্ট আপডেট হয়েছে");
        removeFromCartOnServer(productId);

        removingFromCart.value = false;
      }

      removingFromCart.value = false;
    }
  }

  getCartItems() async {
    if (!AppHelper.isLoggedIn) {
      return;
    }

    final DataResult dataResult = await CartRepo.getCartItems();

    if (dataResult.error == null) {
      final result = dataResult.data != null ? dataResult.data as List<CartItem> : <CartItem>[];
      cartItems.clear();
      for (var item in result) {
        cartItems.add(item);
      }
    }
  }

  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  int get getTotalItemOnCart => cartItems.fold(
        0,
        (previousValue, cart) {
          return previousValue + (cart.qty ?? 0);
        },
      );

  num get getTotalPrice => cartItems.fold(
        0,
        (previousValue, cart) {
          final Product product = cart.product ?? Product();
          double price = product.price ?? 0;
          int qty = cart.qty ?? 0;

          double amount = price * qty;

          return previousValue + amount;
        },
      );
}
