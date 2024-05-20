// ignore_for_file: constant_identifier_names

import 'package:umash_user/data/model/language.dart';
import 'images.dart';

class AppConstants {
  static const String API_KEY = 'AIzaSyCSrHABq5diJg44XTFXpat_ToFHRamrgPU';
  //
  static const String APP_NAME = 'Umash';
  static const String BASE_URL = 'https://umash.hostdonor.com';

  static const String CONFIG_URI = '/api/v1/config';
  static const String POLICY_PAGE = '/api/v1/pages';

  // auth repo
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String REGISTER_URI = '/api/v1/auth/registration';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';
  static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';
  static const String FORGET_PASSWORD_URI = '/api/v1/auth/forgot-password';
  static const String VERIFY_TOKEN_URI = '/api/v1/auth/verify-token';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String CHECK_PHONE_URI = '/api/v1/auth/check-phone?phone=';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String CUSTOMER_REMOVE = '/api/v1/customer/remove-account';
  static const String socialLogin = '/api/v1/auth/social-customer-login';

  // address & location repo
  static const String addressListUri = '/api/v1/customer/address/list';
  static const String removeAddressUri =
      '/api/v1/customer/address/delete?address_id=';
  static const String addAddressUri = '/api/v1/customer/address/add';
  static const String updateAddressUri = '/api/v1/customer/address/update/';
  static const String geocodeUri = '/api/v1/mapapi/geocode-api';
  static const String searchLocationUri =
      '/api/v1/mapapi/place-api-autocomplete';
  static const String placeDetailsUri = '/api/v1/mapapi/place-api-details';
  static const String distanceMatrixUri = '/api/v1/mapapi/distance-api';
  static const String NEAREST_BRANCH = '/api/v1/mapapi/get-nearest-branch';

  // profile repo
  static const String UPDATE_PROFILE_URI = '/api/v1/customer/update-profile';
  static const String CUSTOMER_INFO_URI = '/api/v1/customer/info';

  // category repo
  static const String CATEGORY_LIST_URI = '/api/v1/categories';
  static const String SUB_CATEGORY_LIST_URI = '/api/v1/categories/childes/';
  static const String CATEGORY_PRODUCT_LIST_URI =
      '/api/v1/categories/products/';

  // product repo
  static const String latestProductUri = '/api/v1/products/latest';
  static const String popularProductUri = '/api/v1/products/popular';
  static const String reviewUri = '/api/v1/products/reviews/submit';
  static const String deliverManReviewUri =
      '/api/v1/delivery-man/reviews/submit';

  // banner repo
  static const String bannerUri = '/api/v1/banners';
  static const String productDetailsUri = '/api/v1/products/details/';

  // order repo
  static const String orderListUri = '/api/v1/customer/order/list';
  static const String orderDetailsUri =
      '/api/v1/customer/order/details?order_id=';
  static const String orderCancelUri = '/api/v1/customer/order/cancel';
  static const String updateMethodUri = '/api/v1/customer/order/payment-method';
  static const String trackUri = '/api/v1/customer/order/track?order_id=';
  static const String placeOrderUri = '/api/v1/customer/order/place';
  static const String lastLocationUri =
      '/api/v1/delivery-man/last-location?driver_id=';

  // coupon repo
  static const String couponUri = '/api/v1/coupon/list';
  static const String couponApplyUri = '/api/v1/coupon/apply?code=';

  // wishlist repo
  static const String wishListGetUri = '/api/v1/customer/wish-list';
  static const String addWishListUri = '/api/v1/customer/wish-list/add';
  static const String removeWishListUri = '/api/v1/customer/wish-list/remove';

  // message repo
  static const String messageUri = '/api/v1/customer/message/get';
  static const String sendMessageUri = '/api/v1/customer/message/send';
  static const String getDeliverymanMessageUri =
      '/api/v1/customer/message/get-order-message';
  static const String getAdminMessageUrl =
      '/api/v1/customer/message/get-admin-message';
  static const String sendMessageToAdminUrl =
      '/api/v1/customer/message/send-admin-message';
  static const String sendMessageToDeliveryManUrl =
      '/api/v1/customer/message/send/customer';

  // notification repo
  static const String notificationUri = '/api/v1/notifications';

  // wallet repo
  static const String walletTransactionUrl =
      '/api/v1/customer/wallet-transactions';
  static const String loyaltyTransactionUrl =
      '/api/v1/customer/loyalty-point-transactions';
  static const String loyaltyPointTransferUrl =
      '/api/v1/customer/transfer-point-to-wallet';

  // Shared Key
  static const String THEME = 'theme';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String TOPIC = 'notify';
  static const String TOKEN = 'token';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_EMAIL = 'user_email';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String ON_BOARDING_SKIP = 'on_boarding_skip';
  static const String PLACE_ORDER_DATA = 'place_order_data';
  static const String LOCALIZATION_KEY = 'X-localization';

  // Language
  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: Images.english,
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      imageUrl: Images.arabic,
      languageName: 'Arabic',
      countryCode: 'SA',
      languageCode: 'ar',
    ),
  ];
}
