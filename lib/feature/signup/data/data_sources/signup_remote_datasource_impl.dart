import 'package:educatly_task/config/PrefHelper/prefs.dart';
import 'package:educatly_task/config/routes/app_routes.dart';
import 'package:educatly_task/core/utils/app_colors.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:educatly_task/feature/signup/data/data_sources/signup_remote_datasource.dart';
import 'package:educatly_task/widgets/message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpRemoteDatasourceImpl extends SignUpRemoteDatasource{

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signup(String email, String password , BuildContext context) async{
    String message = '';
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword( // instantiated earlier on: final _firebaseAuth = FirebaseAuth.instance;
        email: email.trim(),
        password: password.trim(),
      );
      saveUserInfo(userCredential.user!.email??'', '', userCredential.user!.uid);
      MessageWidget.showSnackBar('accountCreatedSuccessfully'.tr, AppColors.green);
      Navigator.pushNamed(context, Routes.chat);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      MessageWidget.showSnackBar(message, AppColors.redAlertColor);
    } catch (e) {
      MessageWidget.showSnackBar("Failed: $e", AppColors.redAlertColor);
    }
  }

  @override
  Future<void> saveUserInfo( email, String image, userId) async{
    Prefs.setString(AppStrings.email, email);
    Prefs.setString(AppStrings.image, '');
    Prefs.setString(AppStrings.userId, userId);
    Prefs.setBool(AppStrings.login, true);
  }

}