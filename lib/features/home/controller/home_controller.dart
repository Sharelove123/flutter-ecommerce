import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/home_repositary.dart';
import '../../../core/enums/enums.dart';


final homecontrollerProvider = StateNotifierProvider<HomeController,MyScreenState>((ref){
  final homeRepositary = ref.watch(HomeRepositaryProvider);
  return HomeController(repositary: homeRepositary);
});

class MyScreenState{
  final ScreenType screenType;
  MyScreenState(this.screenType);
}

class HomeController extends StateNotifier<MyScreenState>{
  final HomeRepositary repositary;
  HomeController({required this.repositary}) : super(MyScreenState(ScreenType.Home));

  void changeScreen(ScreenType newscreen){
    state=MyScreenState(newscreen);
  }

}
