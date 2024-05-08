import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eccomerce/core/common/widgets/Iconcard.dart';
import 'package:eccomerce/core/common/widgets/custombutton.dart';
import 'package:eccomerce/core/common/widgets/customdivider.dart';
import 'package:eccomerce/core/utils.dart';
import 'package:eccomerce/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eccomerce/core/common/widgets/customtextfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/common/widgets/modalviewloader.dart';
import '../../../main.dart';

class SignupScreen extends ConsumerStatefulWidget{
  static const routeName = 'signup-screen';

  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController signup_name_controller = TextEditingController();
  final TextEditingController signup_email_controller = TextEditingController();
  final TextEditingController signup_password_controller = TextEditingController();
  String selectedGender = '';
  bool imageSelected = false;
  File? image;


setSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

void selectImage() async {
    var res = await pickImage();
    print("the selected images are $res");
    if (res != null) {
      setState(() {
        image =  File(res.files.first.path!);
        imageSelected = true;
      });
    }
  }

 
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Select Gender',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                RadioListTile<String>(
                  title: Text('Male'),
                  value: 'Male',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setSelectedGender(value!);
                    Navigator.pop(context);
                  },
                  secondary: Icon(Icons.male),
                ),
                RadioListTile<String>(
                  title: Text('Female'),
                  value: 'Female',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setSelectedGender(value!);
                    Navigator.pop(context);
                  },
                  secondary: Icon(Icons.female),
                ),
                RadioListTile<String>(
                  title: Text('Other'),
                  value: 'Other',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setSelectedGender(value!);
                    Navigator.pop(context);
                  },
                  secondary: Icon(Icons.transgender),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
      

  @override
  void dispose() {
    super.dispose();
    signup_name_controller.dispose();
    signup_email_controller.dispose();
    signup_password_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(   
        body:SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: 25,
                    child: GestureDetector(
                      child: FaIcon(FontAwesomeIcons.reply,color: Colors.green,),
                      onTap: (() {
                        getsignin();
                        //Navigator.pushNamed(context, SigninScreen.routeName);
                      }),
                    )
                    ),
                  Center(child: Image.asset("assets/images/s.png",height: MediaQuery.of(context).size.height/3.8,)),
                ],
              ),
            ),
             const Text('Welcome!!!',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),),
             const SizedBox(height: 8,),
             const Text('Create your account',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),
             const SizedBox(height: 28,),
             imageSelected
                    ? GestureDetector(onTap: selectImage,child: CircleAvatar(child: Image.file(image!),radius: 90.0,))
                    : GestureDetector(
                        onTap: selectImage,
                        child: DottedBorder(
                          borderType: BorderType.Circle,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: 250,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                         child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.folder_open,
                              size: 40,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Select Profile Image',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade400,
                               ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
             CustomTextField(iconName: Icon(Icons.person_outline_outlined), hintText: "Enter Username", Password: false, controller: signup_name_controller,),
             CustomTextField(iconName: Icon(Icons.mail_outline_sharp), hintText: "Enter Emailid", Password: false,controller: signup_email_controller,),
             CustomTextField(iconName: Icon(Icons.lock_outlined), hintText: "Enter Password", Password: true,controller: signup_password_controller,),
             const SizedBox(height: 8,),
             OutlinedButton.icon(
              style: OutlinedButton.styleFrom(minimumSize: Size(MediaQuery.of(context).size.width - 70, 50)),
              onPressed: (){
                _showBottomSheet(context);
              },
               icon: Icon(Icons.arrow_downward),
               label: Text('${selectedGender == ''?'Enter gender':selectedGender}')
              ),
             const SizedBox(height: 25,),
             CustomButtom(data: 'Sign up', fun: signup,),
             const SizedBox(height: 35,),
             CustomDivider(data: 'or sign in with'),
             const SizedBox(height: 3,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 IconCard(icon:FaIcon(size:20.0,FontAwesomeIcons.google,color: Colors.green,),fun:(){signInWithGoogle();}),
                 const SizedBox(width: 30,),
                 IconCard(icon:FaIcon(size:20.0,FontAwesomeIcons.facebook,color: Colors.pink,),fun: (){signInWithFacebook();}),
                 const SizedBox(width: 30,),
                 IconCard(icon:FaIcon(size:20.0,FontAwesomeIcons.twitter,color: Colors.blue,),fun: geta),
              ],
             ),
             const SizedBox(height: 40,),
            ]
          ),
        )
      ),
    );
  }

  void geta(){
    print('clicked');
  }

  void signup(){
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
    ref.read(authControllerProvider.notifier).signup(image,signup_name_controller.text.trim(),selectedGender,signup_email_controller.text.trim(), signup_password_controller.text.trim(),context);
    navigatorkey.currentState!.pop();
}

  

  void getsignin(){
    ref.read(authControllerProvider.notifier).changescreen();
  }

  void signInWithGoogle() {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context, true);
  }


  void signInWithFacebook() {
    ref.read(authControllerProvider.notifier).signInWithFacebook(context);
  }
  

}


//Text(ref.watch(authControllerProvider).getsignupdata().toString())