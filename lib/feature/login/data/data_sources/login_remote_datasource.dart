import 'package:flutter/cupertino.dart';

abstract class LoginRemoteDatasource{

  Future<void> login(String email , String password , BuildContext context);

  Future<void> saveUserInfo(String email , String image , userId);
}