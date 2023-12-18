import 'package:get/get.dart';

import '../../../constants/app_helper.dart';
import '../../../models/app_info.dart';
import '../../../models/app_slider.dart';
import '../../../models/data_result.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../models/product_category.dart';
import '../repositories/dashboard_repo.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var searchPageOpened = false.obs;

  var sliders = <AppSlider>[].obs;
  var appInfo = AppInfo().obs;

  var categories = <ProductCategory>[].obs;
  var products = <Product>[].obs;
  var productsByCategory = <Product>[].obs;
  var productsBySearch = <Product>[].obs;
  var allOrders = <Order>[].obs;

  var loadingOrders = false.obs;
  var searchingProduct = false.obs;
  var loadingProducts = false.obs;
  var loadingProductsByCategory = false.obs;

  getAppSliders() async {
    final DataResult dataResult = await DashboardRepo.getSliders();

    if (dataResult.error == null) {
      final sliderList = dataResult.data != null ? dataResult.data as List<AppSlider> : <AppSlider>[];
      sliders.clear();
      for (var item in sliderList) {
        sliders.add(item);
      }
    }
  }

  getCategories() async {
    final DataResult dataResult = await DashboardRepo.getCategories();

    if (dataResult.error == null) {
      final categoryList = dataResult.data != null ? dataResult.data as List<ProductCategory> : <ProductCategory>[];

      categories.clear();
      for (var item in categoryList) {
        categories.add(item);
      }
    }
  }

  getProducts() async {
    loadingProducts.value = true;
    final DataResult dataResult = await DashboardRepo.allProducts();

    if (dataResult.error == null) {
      final productList = dataResult.data != null ? dataResult.data as List<Product> : <Product>[];

      products.clear();
      for (var item in productList) {
        products.add(item);
      }
    }
    loadingProducts.value = false;
  }

  getAllOrders() async {
    if (!AppHelper.isLoggedIn) {
      return;
    }

    loadingOrders.value = true;
    final DataResult dataResult = await DashboardRepo.allOrders();

    if (dataResult.error == null) {
      final itemList = dataResult.data != null ? dataResult.data as List<Order> : <Order>[];

      allOrders.clear();
      for (var item in itemList) {
        allOrders.add(item);
      }
    }
    loadingOrders.value = false;
  }

  searchProduct(String query) async {
    searchingProduct.value = true;
    final DataResult dataResult = await DashboardRepo.searchProduct(query);

    if (dataResult.error == null) {
      final productList = dataResult.data != null ? dataResult.data as List<Product> : <Product>[];

      productsBySearch.clear();
      for (var item in productList) {
        productsBySearch.add(item);
      }
    }
    searchingProduct.value = false;
  }

  getProductsByCategory(String categoryId) async {
    productsByCategory.clear();
    loadingProductsByCategory.value = true;
    final DataResult dataResult = await DashboardRepo.getProductsByCategory(categoryId);

    if (dataResult.error == null) {
      final productList = dataResult.data != null ? dataResult.data as List<Product> : <Product>[];

      for (var item in productList) {
        productsByCategory.add(item);
      }
    }
    loadingProductsByCategory.value = false;
  }

  getAppInfo() async {
    final dataResult = await DashboardRepo.getAppInfo();
    if (dataResult.error == null) {
      appInfo.value = dataResult.data != null ? dataResult.data as AppInfo : AppInfo();
    }
  }

  @override
  void onInit() {
    getAppSliders();
    getCategories();
    getProducts();
    getAppInfo();
    super.onInit();
  }
}
