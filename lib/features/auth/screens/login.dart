import 'package:eccomerce/core/common/widgets/Iconcard.dart';
import 'package:eccomerce/core/common/widgets/custombutton.dart';
import 'package:eccomerce/core/common/widgets/customdivider.dart';
import 'package:eccomerce/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eccomerce/core/common/widgets/customtextfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/common/widgets/modalviewloader.dart';
import '../../../main.dart';

class SigninScreen extends ConsumerStatefulWidget{
  static const routeName = 'signin-screen';

  const SigninScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final TextEditingController signin_email_controller = TextEditingController();
  final TextEditingController signin_password_controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    signin_email_controller.dispose();
    signin_password_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Image.asset("assets/images/s.png",height: MediaQuery.of(context).size.height/3.8,),
             const Text('Welcome Back!',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),),
             const SizedBox(height: 8,),
             const Text('Login to your account',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
             const SizedBox(height: 8,),
             CustomTextField(iconName: Icon(Icons.mail_outline_sharp), hintText: "Enter Emailid", Password: false,controller: signin_email_controller,),
             CustomTextField(iconName: Icon(Icons.lock_outlined), hintText: "Enter Password", Password: true,controller: signin_password_controller),
             const SizedBox(height: 25,),
             CustomButtom(data: 'Sign in', fun:signin),
             const SizedBox(height: 35,),
             const CustomDivider(data: 'or sign in with'),
             const SizedBox(height: 3,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 IconCard(icon:FaIcon(size:20.0,FontAwesomeIcons.google,color: Colors.green,),fun: (){signInWithGoogle();}),
                 const SizedBox(width: 30,),
                 IconCard(icon:FaIcon(size:20.0,FontAwesomeIcons.facebook,color: Colors.pink,),fun: (){signInWithFacebook();}),
                 const SizedBox(width: 30,),
                 IconCard(icon:FaIcon(size:20.0,FontAwesomeIcons.twitter,color: Colors.blue,),fun: geta),
              ],
             ),
             const SizedBox(height: 50,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don t have an account?"),
                TextButton(
                  onPressed:(){
                    getsignup();
                    },
                   child: Text('Sign up here')
                   )
              ],
             )
            ]
          ),
        )
      ),
    );
  }

  void signin(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
         return WillPopScope(
          onWillPop:() async=>false,
          child: ModalView()
        );
      }
    );
    ref.read(authControllerProvider.notifier).signin(signin_email_controller.text.trim(),signin_password_controller.text.trim(),context);
    navigatorkey.currentState!.pop();
  }

  void geta(){
    print('clicked');
  }

  void getsignup(){
    ref.read(authControllerProvider.notifier).changescreen();
  }

  void signInWithGoogle() {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context, true);
  }

   void signInWithFacebook() {
    ref.read(authControllerProvider.notifier).signInWithFacebook(context);
  }

}