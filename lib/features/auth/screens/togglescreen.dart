import 'package:eccomerce/features/auth/controller/auth_controller.dart';
import 'package:eccomerce/features/auth/screens/login.dart';
import 'package:eccomerce/features/auth/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleScreen extends ConsumerWidget {
  const ToggleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final islogin = ref.watch(authControllerProvider);
    if(islogin!=false){
      return SigninScreen();
    }else{
      return SignupScreen();
    }
  }
}