import 'dart:convert';

import 'package:educatly_task/config/PrefHelper/prefs.dart';
import 'package:educatly_task/config/routes/app_routes.dart';
import 'package:educatly_task/core/utils/app_colors.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:educatly_task/feature/login/data/data_sources/login_remote_datasource.dart';
import 'package:educatly_task/widgets/message_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LoginRemoteDatasourceImpl extends LoginRemoteDatasource{
  @override
  Future<void> login(String email, String password , BuildContext context) async{
    String message = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      /*try {
        final response = await http.get(Uri.parse('http://10.0.2.2:3000/users'));
        if (response.statusCode == 200) {
          final List<dynamic> users = json.decode(response.body);
          for(int i =0;i<users.length;i++){
            print(users[i]['uid']);
          }
        } else {
          print('Failed to load users');
        }
      } catch (e) {
        print('Error fetching users: $e');
      }*/
      saveUserInfo(userCredential.user!.email??'', '', userCredential.user!.uid);
      Navigator.pushNamed(context, Routes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        message = 'Invalid login credentials.';
      } else {
        message = e.code;
      }
      MessageWidget.showSnackBar(message, AppColors.primaryColor);
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