import 'package:eccomerce/features/DashBoard/screens/dashboard.dart';
import 'package:eccomerce/features/DashBoard/screens/yourcutomersorders.dart';
import 'package:eccomerce/features/DashBoard/screens/yourorder.dart';
import 'package:eccomerce/features/DashBoard/screens/youruploaded.dart';
import 'package:eccomerce/features/cart/screens/cart.dart';
import 'package:eccomerce/features/home/screens/home.dart';
import 'package:eccomerce/features/products/screens/addproduct_screen.dart';
import 'package:eccomerce/features/products/screens/product_rating_screen.dart';
import 'features/auth/screens/login.dart';
import 'features/auth/screens/signup.dart';
import 'package:flutter/material.dart';

import 'models/arguments.dart';
import 'features/products/screens/product_detail_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignupScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );
    case SigninScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SigninScreen(),
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );
    case ProductDetail.routeName:
      var arguments = routeSettings.arguments as ProductDetailArguments;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetail(
          product: arguments.product, docid: arguments.docid
          ),
      );
    case CartPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartPage(),
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProduct(),
      );
    case ProductReview.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProductReview(),
      );
    case DashBoardPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DashBoardPage(),
      );
    case YourOrder.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const YourOrder(),
      );
    case YourUploads.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const YourUploads(),
      );
    case YourCustomersOrders.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const YourCustomersOrders(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}