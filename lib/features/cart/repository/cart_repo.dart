import '../../../common/api.dart';
import '../../../constants/api_endpoints.dart';
import '../../../models/cart_item.dart';
import '../../../models/data_result.dart';
import '../../../models/response_status.dart';

class CartRepo {
  CartRepo._();

  static Future<DataResult> getCartItems() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.getCarts, true);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => CartItem.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> addToCart(String productId) async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.addToCart(productId), true);

    if (result.error == null) {
      final json = result.json != null ? result.json as Map<String, dynamic> : <String, dynamic>{};

      dataResult.data = ResponseStatus.fromJson(json);
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> removeFromCart(String productId) async {
    final DataResult dataResult = DataResult();

    final result = await Api.delete(ApiEndPoints.removeFromCart(productId));

    if (result.error == null) {
      final json = result.json != null ? result.json as Map<String, dynamic> : <String, dynamic>{};

      dataResult.data = ResponseStatus.fromJson(json);
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }
}
