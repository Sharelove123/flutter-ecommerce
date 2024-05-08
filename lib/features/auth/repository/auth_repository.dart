import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eccomerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../core/failure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/type_defs.dart';
import 'package:eccomerce/core/utils.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(auth:FirebaseAuth.instance,firestore: FirebaseFirestore.instance,googleSignIn: ref.read(googleSignInProvider));
});

class AuthRepository{
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  final GoogleSignIn _googleSignIn;
  AuthRepository({required this.auth,required this.firestore,required GoogleSignIn googleSignIn}):_googleSignIn = googleSignIn;


  //getter of user state
  Stream<User?> get authStateChange => auth.authStateChanges();

  FutureVoid signup( String name, String gender,String email , String password,String imageLink , BuildContext context) async{
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user!;
      return right(savedatatofirestore(name,gender,user,imageLink,context));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> signin( String email , String password , BuildContext context) async{
    try {
      print(email);
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      }else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
       final error = e.code;
       print('$error');
    }
  }

    FutureEither<UserModel> signInWithGoogle(bool isFromLogin) async {
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
        userCredential = await auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        final googleAuth = await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        if (isFromLogin) {
          userCredential = await auth.signInWithCredential(credential);
        } else {
          userCredential = await auth.currentUser!.linkWithCredential(credential);
        }
      }

      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? 'No Name',
          photourl: userCredential.user!.photoURL ?? '',       
          uid: userCredential.user!.uid, 
          email: userCredential.user!.email??'', 
          gender: '',
        );
        await firestore.collection('users').doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // FACEBOOK SIGN IN
  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }


  //Todo
  Future<void> savedatatofirestore(String name,String gender,User userdata,String imageLink,context) async{
    User user;
    user=userdata;
    UserModel userInfo = UserModel(name: name, uid: user.uid, photourl:imageLink , email: user.email??'', gender: gender);

    try {
      await firestore.collection('users').doc(userdata.uid).set(userInfo.toMap());
      } on FirebaseAuthException catch (e) {
          print(e.code);
      } 
  }

  Stream<UserModel> getUserData(String uid) {
    return firestore.collection('users').doc(uid).snapshots().map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<void> signout(context)async {
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    await auth.signOut();
  }
  
   Future<void> deleteAccount(BuildContext context) async {
    try {
      await auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
   }

   Future<void> updatePassword(String email,String oldPassword,String newPassword,BuildContext context) async {
    try {
      var cred = EmailAuthProvider.credential(email: email, password: oldPassword);
      await auth.currentUser!.reauthenticateWithCredential(cred).then((value){
        auth.currentUser!.updatePassword(newPassword);
      });
      showSnackBar(context, 'Password Updated Successfully'); 
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
   }

  FutureVoid updateProfile(UserModel updatedUser,BuildContext context) async {
    try {
      return right(firestore.collection('users').doc(auth.currentUser!.uid).update(updatedUser.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
   }

}