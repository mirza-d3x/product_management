// ignore_for_file: implicit_call_tearoffs

part of 'navigation.dart';

final class AppRoutesFactory implements RoutesFactory {
  @override
  Route createLoginPageRoute() {
    return CustomRoute(
      builder: LoginRouteBuilder(),
    );
  }

  @override
  Route createSignUpPageRoute() {
    return CustomRoute(
      builder: SignupRouteBuilder(),
    );
  }

  @override
  Route createSplashPageRoute() {
    return CustomRoute(
      builder: SplashScreenRouteBuilder(),
    );
  }

  @override
  Route createProductPageRoute() {
    return CustomRoute(
      builder: ProductsRouteBuilder(),
    );
  }

  @override
  Route createPinPageRoute() {
    return CustomRoute(
      builder: PinRouteBuilder(),
    );
  }

  @override
  Route createAddProductsPageRoute() {
    return CustomRoute(
      builder: AddProductsRouteBuilder(),
    );
  }

//   @override
//   Route createProductsPageRoute(ProductModel model) {
//     return CustomRoute(
//       builder: ProductDetailsBuilder(model: model),
//     );
//   }
}

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required super.builder});

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: const Interval(0.00, 0.90, curve: Curves.linearToEaseOut),
      )),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
