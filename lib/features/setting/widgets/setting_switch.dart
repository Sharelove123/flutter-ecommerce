import 'package:eccomerce/features/setting/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationSwitch extends ConsumerStatefulWidget {
  const NotificationSwitch({super.key});



  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationSwitchState();
}


class _NotificationSwitchState extends ConsumerState<NotificationSwitch> {
  bool? switchState;

  @override
  void initState() {
    super.initState();
    ref.read(settingControllerProvider.notifier).get_notification_state();
  }

  void save_notification_state(bool switchState){
    ref.read(settingControllerProvider.notifier).save_notification_state(switchState);
  }

  @override
  Widget build(BuildContext context) {
    bool switchState = ref.watch(settingControllerProvider);
    print('switch data is fere $switchState');
    return CupertinoSwitch(
      value: switchState, 
      onChanged: (newValue){
        save_notification_state(newValue);
      }
    );
  }
}