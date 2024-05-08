import 'package:eccomerce/features/auth/controller/auth_controller.dart';
import 'package:eccomerce/features/auth/screens/togglescreen.dart';
import 'package:eccomerce/features/home/screens/home.dart';
import 'package:eccomerce/models/user_model.dart';
import 'package:eccomerce/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  void setUserData(WidgetRef ref, User data, BuildContext context) async {
    UserModel? userModel;
    try {
      userModel = await ref
          .watch(authControllerProvider.notifier)
          .getUserData(data.uid)
          .first;
      ref.read(userProvider.notifier).update((state) => userModel);
    } catch (e) {
      String? name = data.displayName;
      String? photoURL = data.photoURL;
      String gender = '';
      ref
          .read(authControllerProvider.notifier)
          .savedatatofirestore(name!, gender, data, context, photoURL);
      userModel = await ref
          .watch(authControllerProvider.notifier)
          .getUserData(data.uid)
          .first;
      ref.read(userProvider.notifier).update((state) => userModel);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangeProvider);
    return user.when(
        data: (user) {
          if (user == null) {
            return ToggleScreen();
          }
          setUserData(ref, user, context);
          return HomePage();
        },
        error: (error, showtrace) => Text(error.toString()),
        loading: () => CircularProgressIndicator());
  }
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Eccomerce',
      theme: ThemeData(
          primarySwatch: Colors.blue, appBarTheme: AppBarTheme(elevation: 0)),
      home: AuthWrapper(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorkey,
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
