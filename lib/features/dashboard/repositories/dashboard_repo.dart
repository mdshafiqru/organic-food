import '../../../common/api.dart';
import '../../../constants/api_endpoints.dart';
import '../../../models/app_info.dart';
import '../../../models/app_slider.dart';
import '../../../models/data_result.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../models/product_category.dart';

class DashboardRepo {
  DashboardRepo._();

  static Future<DataResult> getSliders() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.getSliders, false);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => AppSlider.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> getCategories() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.getCategories, false);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => ProductCategory.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> allProducts() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.allProducts(), false);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => Product.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> allOrders() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.allOrders(), true);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => Order.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> searchProduct(String query) async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.searchProducts(query), false);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => Product.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> getProductsByCategory(String categoryId) async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.productsByCategory(categoryId), false);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => Product.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> getAppInfo() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.getAppInfo, false);

    if (result.error == null) {
      final json = result.json != null ? result.json as Map<String, dynamic> : <String, dynamic>{};

      dataResult.data = AppInfo.fromJson(json);
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }
}
