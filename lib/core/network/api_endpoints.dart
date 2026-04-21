class ApiEndpoints {
  static const String base = 'https://mccc.co.in/alchefmeat/';
  static const String apiEndPoint = '${base}api/v1/';

  //<-------------------------- AUTH -------------------------->
  static const String termsAndConditions = '${base}terms_conditions';
  static const String countries = 'countries';
  static const String login = 'login';
  static const String verifyOtp = 'verifyotp';
  static const String resendOtp = 'resend-otp';
  static const String updateProfile = 'update-profile';
  static const String logout = 'logout';

  //<-------------------------- ADDRESS -------------------------->
  static const String addressList = 'show/address';
  static const String addAddress = 'add/address';
  static const String emirates = 'emirates';

  //<-------------------------- HOME -------------------------->
  static const String banners = 'banners';
  static const String homeCategoryProducts = 'home_category_product';

  //<-------------------------- CATEGORIES -------------------------->
  static const String categories = 'categories_list';

  //<-------------------------- PRODUCTS -------------------------->
  static const String products = 'products';
  static const String productDetail = 'product-detalis';

  //<-------------------------- COUPONS -------------------------->
  static const String coupons = 'show/coupons';

  //<-------------------------- CART -------------------------->
  static const String viewCart = 'view/cart';
  static const String addCart = 'add/cart';
  static const String removeCart = 'delete/cart';
  static const String orderCalculation = 'order_calculation';
  static const String clearCart = 'clear/cart';
  static const String slots = 'time-slot';
  static const String reviewCart = 'review_cart';
  static const String placeOrder = 'init/order';

  //<-------------------------- ORDERS -------------------------->
  static const String orders = 'orders';
  static const String orderDetail = 'order-items';

  //<-------------------------- PROFILE -------------------------->
  static const String updateProfileImage = 'update-profile-image';
}
