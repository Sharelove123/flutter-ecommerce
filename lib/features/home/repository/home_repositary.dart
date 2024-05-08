import 'package:flutter_riverpod/flutter_riverpod.dart';

final HomeRepositaryProvider = Provider((ref){
  return HomeRepositary();
});

class HomeRepositary{
  
  void repo(){
    print('repo');
  }

}