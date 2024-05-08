import 'package:eccomerce/core/enums/enums.dart';
import 'package:eccomerce/features/DashBoard/screens/dashboard.dart';
import 'package:eccomerce/features/cart/screens/cart.dart';
import 'package:eccomerce/features/home/controller/home_controller.dart';
import 'package:eccomerce/features/home/screens/widgets/bottomnavbar.dart';
import 'package:eccomerce/features/products/screens/homescreen.dart';
import 'package:eccomerce/features/setting/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget{
  static const routeName = 'home-screen';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homecontrollerProvider);
    Widget currentScreen;

    switch (state.screenType) {
      case ScreenType.Home:
        currentScreen = HomeScreen();
        break;
      case ScreenType.Setting:
        currentScreen = Setting();
        break;
      case ScreenType.Cart:
        currentScreen = CartPage();
        break;
      case ScreenType.dashboard:
        currentScreen = DashBoardPage();
        break;
      default:
        currentScreen = HomeScreen();
        break;
      
    }


    return Scaffold(
      body:Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration:BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color.fromRGBO(234, 224, 218,1),Color.fromRGBO(253, 241, 233,1)]
                  )
              ),
              child: currentScreen
            ),
          ),
           Align(
              alignment: Alignment.bottomCenter,
                child: NavBar()
                )
        ],
      ),
      
    );
  }
}