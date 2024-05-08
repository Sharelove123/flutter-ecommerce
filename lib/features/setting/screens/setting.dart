import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eccomerce/core/common/widgets/custombutton.dart';
import 'package:eccomerce/core/common/widgets/customtextfield.dart';
import 'package:eccomerce/core/enums/enums.dart';
import 'package:eccomerce/core/utils.dart';
import 'package:eccomerce/features/auth/controller/auth_controller.dart';
import 'package:eccomerce/features/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eccomerce/features/setting/widgets/setting_switch.dart';

class Setting extends ConsumerStatefulWidget {
  static const routeName = 'Setting-screen';
  const Setting({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingState();
}

class _SettingState extends ConsumerState<Setting> {
  //update password
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController oldpassword_controller = TextEditingController();
  final TextEditingController newpassword_controller = TextEditingController();
  final _updatePasswordFormKey = GlobalKey<FormState>();


  //update profile
  final TextEditingController name_controller = TextEditingController();
  String selectedGender = '';
  bool imageSelected = false;
  File? image;


  setSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
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
    email_controller.dispose();
    oldpassword_controller.dispose();
    newpassword_controller.dispose();
    name_controller.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0, left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  go_to_home(ref, 0);
                },
              ),
              Text(
                'Setting',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                title: Text('Account'),
                leading: Icon(Icons.person_outlined),
              ),
              Divider(
                thickness: 1,
              ),
              ExpansionTile(
                  title: Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  shape: RoundedRectangleBorder(),
                  children: [
                    imageSelected
                      ? GestureDetector(onTap: selectImage,child: CircleAvatar(child: Image.file(image!),radius: 90.0,))
                      : GestureDetector(
                          onTap: selectImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: 200,
                              height: 150,
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
                    CustomTextField(
                      hintText: 'Enter your name',
                      controller: name_controller, 
                      iconName: Icon(Icons.person_outline), 
                      Password: false,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(minimumSize: Size(MediaQuery.of(context).size.width - 70, 50)),
                      onPressed: (){
                        _showBottomSheet(context);
                      },
                      icon: Icon(Icons.arrow_downward),
                      label: Text('${selectedGender == ''?'Enter gender':selectedGender}')
                      ),
                      SizedBox(
                      height: 15,
                    ),
                    CustomButtom(
                      data: 'Submit', 
                      fun: (){
                        updateProfile();
                      }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
              ),
              Form(
                key: _updatePasswordFormKey,
                child: ExpansionTile(
                    title: Text(
                      'Change Password',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    shape: RoundedRectangleBorder(),
                    children: [
                      CustomTextField(
                        hintText: 'Enter your email',
                        controller: email_controller, 
                        iconName: Icon(Icons.email_outlined), 
                        Password: false,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: 'Enter your oldpassword',
                        controller: oldpassword_controller, 
                        iconName: Icon(Icons.lock_outline), 
                        Password: true,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: 'Enter your newpassword',
                        controller: newpassword_controller, 
                        iconName: Icon(Icons.lock_outline), 
                        Password: true,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomButtom(
                        data: 'Submit', 
                        fun: (){
                          updatePAssword();
                        }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]
                    //  trailing: Icon(Icons.arrow_forward_ios,size: 20,color: Colors.grey.shade500),
                    ),
              ),
              ExpansionTile(
                title: Text(
                  'delete account',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                //trailing: Icon(Icons.delete,size: 25,color: Colors.grey.shade500),
                shape: RoundedRectangleBorder(),
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' Are you sure you want to delete your account??',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: OutlinedButton.icon(
                        onPressed: () {
                          delete_account(ref, context);
                        },
                        icon: Icon(Icons.delete, size: 25, color: Colors.red),
                        label: Text(
                          'Delete',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                  title: Text(
                    'Notifications',
                  ),
                  leading: Icon(
                    Icons.notifications_outlined,
                  )),
              Divider(
                thickness: 1,
              ),
              ListTile(
                  title: Text(
                    'Notifications',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  trailing: NotificationSwitch()),
              ListTile(
                  title: Text(
                    'Add notifications',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  trailing: NotificationSwitch()),
              SizedBox(
                height: 40,
              ),
              ListTile(
                  title: Text(
                    'More',
                  ),
                  leading: Icon(
                    Icons.add_box_outlined,
                  )),
              Divider(
                thickness: 1,
              ),
              ListTile(
                  title: Text(
                    'Language',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 20, color: Colors.grey.shade500)),
              ListTile(
                  title: Text(
                    'Country',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 20, color: Colors.grey.shade500)),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          shadowColor: Colors.black),
                      onPressed: () {
                        signout(context, ref);
                      },
                      icon: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ))),
              SizedBox(
                height: 140,
              ),
            ],
          ),
        ),
      ),
    );
  }

  signout(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signout(context);
  }

  void go_to_home(WidgetRef ref, int index) {
    ref
        .read(homecontrollerProvider.notifier)
        .changeScreen(ScreenType.values[index]);
  }

  void delete_account(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).deleteAccount(context);
  }

  void updatePAssword(){
    if (_updatePasswordFormKey.currentState!.validate()){
      ref.read(authControllerProvider.notifier).updatePassword(
        email_controller.text.trim(),
        oldpassword_controller.text.trim(),
        newpassword_controller.text.trim(),
        context
      );
    }

  email_controller.clear();
  oldpassword_controller.clear();
  newpassword_controller.clear();
  }

  void updateProfile(){
    if(name_controller.text.trim().length!=0 && selectedGender.trim().length!=0){  
      ref.read(authControllerProvider.notifier).updateProfile(
          file: image, 
          name: name_controller.text.trim(), 
          gender: selectedGender, 
          ref: ref, 
          context: context
        );

    name_controller.clear();
    }else{
      showSnackBar(context, 'Enter data correctly');
    }
  }
}
