part of 'navigation.dart';

abstract interface class RoutesFactory {
  Route<dynamic> createSplashPageRoute();
  Route<dynamic> createLoginPageRoute();
  Route<dynamic> createSignUpPageRoute();
  Route<dynamic> createProductPageRoute();
  Route<dynamic> createPinPageRoute();
  // Route<dynamic> createProductsPageRoute(ProductModel model);
}
