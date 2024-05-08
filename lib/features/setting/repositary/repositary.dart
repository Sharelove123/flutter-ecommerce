import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingRepositoryProvider = Provider<SettingRepository>((ref){
  return SettingRepository(
    auth:FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class SettingRepository{
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  SettingRepository({required this.auth,required this.firestore});


  //both Notification and Add notification are same
  Future<bool> get_notification_state()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? switchState = await prefs.getBool('switchstate');
    if(switchState!=null){
      return switchState;
    }else{
    return true;
    }
  }

  //both Notification and Add notification are same
  void save_notification_state(bool newState)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('switchstate', newState);
  }

}