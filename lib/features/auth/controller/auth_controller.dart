import 'dart:io';
import 'package:eccomerce/core/providers/storage_repository_provider.dart';
import 'package:eccomerce/core/utils.dart';
import 'package:eccomerce/features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider((ref) {
   final authRepository = ref.watch(authRepositoryProvider);
   final storageRepository = ref.watch(storageRepositoryProvider);
   return AuthController(authRepository: authRepository,ref: ref, storageRepository: storageRepository);
});


class AuthController extends StateNotifier{
    final AuthRepository authRepository;
    final Ref _ref;
    final StorageRepository _storageRepository;
    AuthController({
        required this.authRepository,
        required Ref ref,
        required StorageRepository storageRepository
    }) : _ref = ref,_storageRepository=storageRepository,super(true);


    void signup( File? file,String name, String gender,String email , String password , BuildContext context) async{
      if(file!.length()!=0){
        state = true;
        String postId = const Uuid().v1();
        UserModel? user = _ref.read(userProvider);
        String userId = user!.uid;
        final imageRes = await _storageRepository.storeFile(
        path: 'userImage/${userId}',
        id: postId,
        file: file,
      );
        imageRes.fold((l) => showSnackBar(context, l.message), (r) async {
          await authRepository.signup(name,gender,email,password,r,context);
          showSnackBar(context, 'User created Successfully');
        }
      );
      }else{
        await authRepository.signup(name,gender,email,password,'',context);
        showSnackBar(context, 'User created Successfully');
      }
    }

    void signin(email,password,context) async{
      await authRepository.signin(email,password,context);
    }

    void signInWithGoogle(BuildContext context, bool isFromLogin) async {
    final user = await authRepository.signInWithGoogle(isFromLogin);
    user.fold(
      (l){
        print(l.message);
        showSnackBar(context, l.message);
        },
      (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

    void signInWithFacebook(BuildContext context) async {
       await authRepository.signInWithFacebook(context);
    }

    Future<void> signout(BuildContext context)async{
      await authRepository.signout(context);
    }

    Stream<User?> get authStateChange => authRepository.authStateChange;

  
    void changescreen(){
      if(state==false){
        state = true;
      }else{
        state=false;
      }
    }

    Stream<UserModel?> getUserData(String uid){
      return authRepository.getUserData(uid);
    }

    void savedatatofirestore(String name,String gender,User userdata,BuildContext context, String? photoURL) async{
      await authRepository.savedatatofirestore( name, gender, userdata, userdata.photoURL??'' ,context);
    }

    void deleteAccount(BuildContext context)async{
      await authRepository.deleteAccount(context);
    }

    void updatePassword(String email,String oldPassword,String newPassword,BuildContext context)async{
      await authRepository.updatePassword(email, oldPassword, newPassword, context);
    }

    void updateProfile({
      required File? file,
      required String? name , 
      required String? gender , 
      required WidgetRef? ref,
      required BuildContext context
      })async{
        state = true;
        String postId = const Uuid().v1();
        UserModel? user = _ref.read(userProvider);
        String userId = user!.uid;
        final imageRes = await _storageRepository.storeFile(
        path: 'userImage/${userId}',
        id: postId,
        file: file,
      );
        imageRes.fold((l) => showSnackBar(context, l.message), (r) async {
        print('entered right');
        UserModel? updatedUser;
        updatedUser = _ref.read(userProvider)!;
        updatedUser = updatedUser.copyWith(name: name,gender: gender,photourl: r);
        print(updatedUser.toMap());
        await authRepository.updateProfile(updatedUser, context);
        showSnackBar(context,'Profile Updated Sccessfully');
      }
    );
    }

}

final authStateChangeProvider = StreamProvider<User?>((ref){
  final usercurrentauth = ref.watch(authControllerProvider.notifier);
  return usercurrentauth.authStateChange;
});
