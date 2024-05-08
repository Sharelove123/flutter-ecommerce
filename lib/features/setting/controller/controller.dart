import 'package:eccomerce/features/setting/repositary/repositary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final settingControllerProvider = StateNotifierProvider<SettingController,bool>((ref) {
   final settingRepository = ref.watch(settingRepositoryProvider);
   return SettingController(settingRepository: settingRepository,ref: ref);
});


class SettingController extends StateNotifier<bool>{
    final SettingRepository settingRepository;
    final Ref _ref;
    SettingController({
        required this.settingRepository,
        required Ref ref
    }) : _ref = ref,super(false);


  //both Notification and Add notification are same
  void get_notification_state()async{
    bool res =  await settingRepository.get_notification_state();
    state=res;
  }

  void save_notification_state(bool newState){
    state = newState;
    settingRepository.save_notification_state(newState);
  }
}