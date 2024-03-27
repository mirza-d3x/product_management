part of 'navigation.dart';

Route<dynamic>? Function(RouteSettings)? onGenerateAppRoute(
    RoutesFactory routesFactory) {
  return (RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return routesFactory.createSplashPageRoute();
      case RouteNames.login:
        return routesFactory.createLoginPageRoute();
      case RouteNames.signUp:
        return routesFactory.createSignUpPageRoute();
      case RouteNames.products:
        return routesFactory.createProductPageRoute();
      case RouteNames.pin:
        return routesFactory.createPinPageRoute();
      //   return routesFactory.createCartPageRoute();
      // case RouteNames.products:
      //   return routesFactory
      //       .createProductsPageRoute(settings.arguments as ProductModel);
    }
    return null;
  };
}
