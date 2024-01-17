class ApiEndPoints {
  ApiEndPoints._();
  static const _apiBaseUrl = 'http://10.0.2.2:3000/v1/user';
  static const _rootUrl = 'http://10.0.2.2:3000/';

  // static const _apiBaseUrl = 'https://organicfoods.passivedesk.com/v1/user';
  // static const _rootUrl = 'https://organicfoods.passivedesk.com/';

// auth api
  static const _login = "$_apiBaseUrl/login";
  static const _user = "$_apiBaseUrl/user";
  static const _register = "$_apiBaseUrl/register";

  static const _getAppInfo = "$_apiBaseUrl/get-app-info";
  static const _getCategories = "$_apiBaseUrl/get-categories";
  static const _getSliders = "$_apiBaseUrl/get-sliders";
  static const _getCarts = "$_apiBaseUrl/get-carts";
  static const _getDivisions = "$_apiBaseUrl/get-divisions";
  static const _getAddresses = "$_apiBaseUrl/get-addresses";
  static const _createAddress = "$_apiBaseUrl/create-address";
  static const _createOrder = "$_apiBaseUrl/create-order";

  static String get rootUrl => _rootUrl;

  static String get login => _login;
  static String get user => _user;
  static String get register => _register;

  static String get getAppInfo => _getAppInfo;
  static String get getCategories => _getCategories;
  static String get getSliders => _getSliders;
  static String get getCarts => _getCarts;
  static String get getDivisions => _getDivisions;
  static String get getAddresses => _getAddresses;
  static String get createAddress => _createAddress;
  static String get createOrder => _createOrder;

  static String deleteAddress(String id) {
    return "$_apiBaseUrl/delete-address/id=$id";
  }

  static String removeFromCart(String productId) {
    return "$_apiBaseUrl/remove-from-cart/productId=$productId";
  }

  static String addToCart(String productId) {
    return "$_apiBaseUrl/add-to-cart/productId=$productId";
  }

  static String searchProducts(String query) {
    return "$_apiBaseUrl/search-products/query=$query";
  }

  static String allProducts({int? skip = 0}) {
    return "$_apiBaseUrl/all-products/skip=$skip";
  }

  static String allOrders({int? skip = 0}) {
    return "$_apiBaseUrl/all-orders/skip=$skip";
  }

  static String productsByCategory(String categoryId, {int? skip = 0}) {
    return "$_apiBaseUrl/products-by-category/categoryId=$categoryId/skip=$skip";
  }
}
